import 'package:book_movie/constants/TEXTSTYLES.dart';
import 'package:book_movie/controller/firebase.dart';
import 'package:book_movie/models/Movie.dart';
import 'package:book_movie/models/Ticket.dart';
import 'package:book_movie/screens/user/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class SelectSeatScreen extends StatefulWidget {
  Movie movie;
  String theatreName;
  String time;
  String date;
  SelectSeatScreen({this.movie, this.theatreName, this.time, this.date});
  @override
  _SelectSeatScreenState createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  List selected = [];
  List blocked = [];
  int rows = 10;
  int columns = 5;
  @override
  void initState() {
    super.initState();
    selected.clear();
    blocked.clear();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        if ((i % 2 == 0) && (j % 2 == 1)) {
          blocked.add(i.toString() + j.toString());
        } else if ((i % 2 == 1) && (j % 2 == 0)) {
          blocked.add(i.toString() + j.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(blocked);
    print(selected);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.theatreName,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${widget.movie.name}", style: label_style),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.date}", style: label_style),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.time}",
                    style: label_style,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Rs.${widget.movie.price}", style: label_style),
            ),
            for (int i = 0; i < rows; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int j = 0; j < columns; j++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          child: blocked.contains(i.toString() + j.toString())
                              ? SvgPicture.asset("assets/icons/blockedSeat.svg")
                              : selected.contains(i.toString() + j.toString())
                                  ? SvgPicture.asset("assets/icons/redSeat.svg")
                                  : SvgPicture.asset(
                                      "assets/icons/greenSeat.svg"),
                          onTap: () {
                            if (selected
                                .contains(i.toString() + j.toString())) {
                              setState(() {
                                selected.remove(i.toString() + j.toString());
                              });
                            } else if (!blocked
                                    .contains(i.toString() + j.toString()) &&
                                !selected
                                    .contains(i.toString() + j.toString())) {
                              setState(() {
                                selected.add(i.toString() + j.toString());
                              });
                            }
                          }),
                    )
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No of Seats Selected:${selected.length}',
                  style: label_style),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Total Price:${selected.length * int.parse(widget.movie.price)}',
                  style: label_style),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selected.isEmpty) {
            Toast.show("No seat selected", context, gravity: Toast.BOTTOM);
          } else {
            Ticket ticket = new Ticket(
              amt: (selected.length * int.parse(widget.movie.price)).toString(),
              location: widget.theatreName,
              name: widget.movie.name,
              seats: selected,
              time: widget.time,
              date: widget.date,
            );
            uploadTicket(ticket);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TicketScreen(ticket: ticket),
              ),
            );
          }
        },
        child: Icon(Icons.money),
      ),
    );
  }
}
