import 'package:book_movie/constants/BOXSTYLES.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List moviesList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/addMovie');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: Column(
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
          ListView.builder(
            itemCount: moviesList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(moviesList[index].toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
