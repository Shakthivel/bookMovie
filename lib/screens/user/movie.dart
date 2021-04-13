import 'package:book_movie/constants/TEXTSTYLES.dart';
import 'package:book_movie/models/Movie.dart';
import 'package:book_movie/screens/user/selectSeat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  Movie movie;

  MovieScreen({this.movie});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String movieUrl;
  DateTime selectedDate = DateTime.now();
  var pickedDate;
  String displayDate =
      DateTime.now().toString().substring(0, 11).split("-").reversed.join('/');

  @override
  void initState() {
    super.initState();
    retrieveMovieImg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movieUrl == null
                ? CircularProgressIndicator()
                : Center(
                    child: Image.network(
                      movieUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.movie.name}",
                    style: label_style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.movie.releaseDate}",
                    style: label_style,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'PLOT:',
                style: label_style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.movie.plot}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "CAST:",
                style: label_style,
              ),
            ),
            SingleChildScrollView(
              child: Row(
                children: [
                  for (String i in widget.movie.cast)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Container(
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          i,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "GENRES:",
                style: label_style,
              ),
            ),
            SingleChildScrollView(
              child: Row(
                children: [
                  for (String i in widget.movie.genres)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Container(
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          i,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "LANGUAGES:",
                style: label_style,
              ),
            ),
            SingleChildScrollView(
              child: Row(
                children: [
                  for (String i in widget.movie.language)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Container(
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          i,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "THEATRES:",
                    style: label_style,
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(displayDate),
                  ),
                  onTap: () async {
                    DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: selectedDate,
                      lastDate: selectedDate.add(Duration(days: 7)),
                    );

                    if (picked != null) {
                      setState(() {
                        pickedDate = picked
                            .toString()
                            .substring(0, 11)
                            .split("-")
                            .join('/');

                        displayDate =
                            pickedDate.toString().split('/').reversed.join('/');
                      });
                    }
                  },
                ),
              ],
            ),
            ListView.builder(
              itemCount: widget.movie.theatre.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctx, int index) {
                String theatreName = widget.movie.theatre[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(theatreName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.white,
                                child: Text("15.00"),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectSeatScreen(
                                        movie: widget.movie,
                                        theatreName: theatreName,
                                        time: "15.00",
                                        date: displayDate),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.white,
                                child: Text("18.00"),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectSeatScreen(
                                      movie: widget.movie,
                                      theatreName: theatreName,
                                      time: "18.00",
                                      date: displayDate,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.white,
                                child: Text("21.00"),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectSeatScreen(
                                      movie: widget.movie,
                                      theatreName: theatreName,
                                      time: "21.00",
                                      date: displayDate,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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
