import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

Future<File> getImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Widget uploadImageContainer(File image) {
  return Container(
      color: Colors.blue[100],
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: image != null
                ? Image.file(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    'assets/images/add_pic.svg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ));
}
