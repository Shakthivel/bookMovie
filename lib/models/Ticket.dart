class Ticket {
  String name;
  String location;
  String time;
  List seats;
  String amt;
  String date;

  Ticket(
      {this.amt, this.location, this.name, this.seats, this.time, this.date});
  Ticket.fromJson(var value) {
    this.name = value["name"];
    this.location = value["location"];
    this.amt = value["amt"];
    this.date = value["date"];
    this.seats = value["seats"];
    this.time = value["time"];
  }
}
