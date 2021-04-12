import 'package:book_movie/constants/BOXSTYLES.dart';
import 'package:book_movie/constants/TEXTSTYLES.dart';
import 'package:book_movie/models/Movie.dart';
import 'package:book_movie/screens/user/movie.dart';
import 'package:book_movie/widgets/viewMovieCards.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List moviesList = [];
  int _current = 0;
  List<String> imgList = [];
  @override
  void initState() {
    super.initState();
    retrieveImgList();
    retrieveMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: Colors.grey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: searchDec,
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recommended",
              style: label_style,
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                autoPlayInterval: Duration(
                  seconds: 5,
                ),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: imgList
                .map(
                  (item) => Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: item == null
                            ? SvgPicture.asset("assets/images/add_pic.svg")
                            : Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Movies",
              style: label_style,
            ),
          ),
          ListView.builder(
            itemCount: moviesList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, int index) {
              Movie m = moviesList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: InkWell(
                    child: viewMovieCards(movie: m),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieScreen(movie: m),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }

  retrieveImgList() async {
    imgList.clear();
    final fb = FirebaseDatabase.instance;
    final ref = fb.reference();
    final response = ref.child("images").once();
    await response.then((DataSnapshot data) {
      for (var value in data.value.values) {
        imgList.add(value["url"]);
      }
    });
    setState(() {});
  }

  retrieveMoviesList() async {
    moviesList.clear();
    final fb = FirebaseDatabase.instance;
    final ref = fb.reference();
    final response = ref.child("movies").once();
    await response.then((DataSnapshot data) {
      for (var value in data.value.values) {
        moviesList.add(new Movie.fromJson(value));
      }
    });
    setState(() {});
  }
}
