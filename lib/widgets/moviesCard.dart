import 'package:book_movie/models/Movie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoviesCard extends StatefulWidget {
  Movie movie;

  MoviesCard({this.movie});

  @override
  _MoviesCardState createState() => _MoviesCardState();
}

class _MoviesCardState extends State<MoviesCard> {
  String movieUrl;

  @override
  void initState() {
    super.initState();
    retrieveMovieImg();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: movieUrl == null
                      ? CircularProgressIndicator()
                      : Center(
                          child: Image.network(
                            movieUrl,
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.movie.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.movie.plot,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  Text(
                    widget.movie.releaseDate,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  retrieveMovieImg() async {
    final fb = FirebaseDatabase.instance;
    final ref = fb.reference();
    final response = ref
        .child("images")
        .child(widget.movie.name.toLowerCase().trim().replaceAll(" ", ""))
        .once();
    await response.then((DataSnapshot data) {
      movieUrl = data.value["url"];
    });
    setState(() {});
  }
}
