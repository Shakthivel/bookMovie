import 'dart:io';

import 'package:book_movie/constants/BOXSTYLES.dart';
import 'package:book_movie/constants/TEXTSTYLES.dart';
import 'package:book_movie/controller/firebase.dart';
import 'package:book_movie/models/Movie.dart';
import 'package:book_movie/screens/admin/pickfile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class EditMovieScreen extends StatefulWidget {
  Movie movie;

  EditMovieScreen({this.movie});

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  var _formKey = GlobalKey<FormState>();

  String title;
  TextEditingController _titleController = TextEditingController();
  String plot;
  TextEditingController _plotController = TextEditingController();
  String cast;
  TextEditingController _castController = TextEditingController();
  String genre;
  TextEditingController _genreController = TextEditingController();
  String releaseDate;
  TextEditingController _releaseDateController = TextEditingController();
  String language;
  TextEditingController _languageController = TextEditingController();
  String price;
  TextEditingController _priceController = TextEditingController();
  String theatreTimings;
  TextEditingController _theatreController = TextEditingController();

  final picker = ImagePicker();

  File movieImage;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.movie.name;
    _plotController.text = widget.movie.plot;
    _castController.text = widget.movie.cast.join(",");
    _genreController.text = widget.movie.genres.join(",");
    _releaseDateController.text = widget.movie.releaseDate;
    _languageController.text = widget.movie.language.join(",");
    _theatreController.text = widget.movie.theatre.join(",");
    _priceController.text = widget.movie.price;
  }

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
                  "Edit the Movie",
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
                  controller: _titleController,
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
                  controller: _plotController,
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
                  controller: _castController,
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
                  controller: _genreController,
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
                  controller: _releaseDateController,
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
                  controller: _languageController,
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
                  controller: _priceController,
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
                  controller: _theatreController,
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
                      child: shadowButton(bText: "Update"),
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
