import 'package:book_movie/models/Ticket.dart';
import 'package:book_movie/widgets/historyCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ticket.dart';

class HistoryFragment extends StatefulWidget {
  @override
  _HistoryFragmentState createState() => _HistoryFragmentState();
}

class _HistoryFragmentState extends State<HistoryFragment> {
  List<Ticket> historyList = [];

  @override
  void initState() {
    super.initState();
    retrieveTicketsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: historyList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext ctx, int index) {
            Ticket t = historyList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: InkWell(
                  child: HistoryCard(ticket: t),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketScreen(ticket: t),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  retrieveTicketsList() async {
    historyList.clear();
    final fb = FirebaseDatabase.instance;
    final ref = fb.reference();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final response = ref
        .child("users")
        .child(prefs.getString("uid"))
        .child("tickets")
        .once();
    await response.then((DataSnapshot data) {
      for (var value in data.value.values) {
        historyList.add(new Ticket.fromJson(value));
      }
    });
    setState(() {});
  }
}
