class Movie {
  String name;
  String plot;
  List genres;
  List cast;
  List language;
  String releaseDate;
  String price;
  List theatre;

  Movie({
    this.name,
    this.plot,
    this.genres,
    this.language,
    this.releaseDate,
    this.cast,
    this.price,
    this.theatre,
  });

  Movie.fromJson(var value) {
    this.name = value["name"];
    this.plot = value["plot"];
    this.genres = value["genres"];
    this.language = value["language"];
    this.releaseDate = value["releaseDate"];

    this.cast = value["cast"];
    this.price = value["price"].toString();
    this.theatre = value["theatre"];
  }
}
