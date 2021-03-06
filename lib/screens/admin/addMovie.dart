import 'dart:io';

import 'package:book_movie/constants/BOXSTYLES.dart';
import 'package:book_movie/constants/TEXTSTYLES.dart';
import 'package:book_movie/controller/firebase.dart';
import 'package:book_movie/models/Movie.dart';
import 'package:book_movie/screens/admin/pickfile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddMovieScreen extends StatefulWidget {
  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  var _formKey = GlobalKey<FormState>();
  String title;
  String plot;
  String cast;
  String genre;
  String releaseDate;
  String language;
  String price;
  String theatreTimings;

  @override
  void initState() {
    super.initState();
  }

  File movieImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Add A Movie",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                  child: uploadImageContainer(movieImage),
                  onTap: () async {
                    getImage().then((value) => {
                          if (value != null)
                            {
                              setState(() {
                                movieImage = value;
                              })
                            }
                        });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Title:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    title = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Plot:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  maxLines: 15,
                  minLines: 4,
                  onSaved: (value) {
                    plot = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Cast:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    cast = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Genre:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    genre = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Release Date:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    releaseDate = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Language:",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    language = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Price Per Ticket",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    price = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Theatre",
                  style: label_style,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("empty");
                    }
                    return null;
                  },
                  decoration: inputFieldDec,
                  onSaved: (value) {
                    theatreTimings = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: shadowButton(bText: "Add"),
                      onTap: () {
                        if (movieImage != null) {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            Movie m = Movie(
                              cast: cast.split(","),
                              genres: genre.split(','),
                              language: language.split(","),
                              name: title,
                              plot: plot,
                              price: price,
                              releaseDate: releaseDate,
                              theatre: theatreTimings.split(","),
                            );
                            uploadMovie(m, movieImage);
                            _formKey.currentState.reset();
                            setState(() {
                              movieImage = null;
                            });
                            Navigator.of(context)
                                .pushReplacementNamed('/admin');
                          }
                        } else {
                          Toast.show("Please select an image", context,
                              gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
