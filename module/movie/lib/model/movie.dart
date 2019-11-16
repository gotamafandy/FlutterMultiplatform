class Movie {
  final String title;
  final String year;
  final Uri poster;

  Movie({this.title, this.year, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      year: json['year'],
      poster: Uri.parse(json['poster'])
    );
  }
}
