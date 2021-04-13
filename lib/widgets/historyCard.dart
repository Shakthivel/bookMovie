import 'package:book_movie/constants/TEXTSTYLES.dart';
import 'package:book_movie/models/Ticket.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  Ticket ticket;
  HistoryCard({this.ticket});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blueGrey[100],
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                  child: Text(
                    "${ticket.name}",
                    style: label_style,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                  child: Text("${ticket.location}"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                  child: Text("${ticket.date}"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                  child: Text("${ticket.time}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
