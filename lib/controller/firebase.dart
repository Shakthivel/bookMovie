import 'dart:io';

import 'package:book_movie/models/Movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

uploadMovie(Movie m, File pic) async {
  final fb = FirebaseDatabase.instance;
  final ref = fb.reference();
  var storage = FirebaseStorage.instance;
  await ref
      .child("movies")
      .child(m.name.toLowerCase().trim().replaceAll(" ", ""))
      .set(<String, Object>{
    "name": m.name,
    "plot": m.plot,
    "genres": m.genres,
    "cast": m.cast,
    "language": m.language,
    "releaseDate": m.releaseDate,
    "theatre": m.theatre,
    "price": m.price,
  });
  TaskSnapshot snapshot = await storage
      .ref()
      .child("images/${m.name..toLowerCase().trim().replaceAll(" ", "")}")
      .putFile(pic);
  if (snapshot.state == TaskState.success) {
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    await ref
        .child("images")
        .child(m.name.toLowerCase().trim().replaceAll(" ", ""))
        .set({"url": downloadUrl});
  } else {
    print('Error from image repo ${snapshot.state.toString()}');
    throw ('This file is not an image');
  }
}
