import 'dart:convert';

import 'package:movie/model/movie.dart';
import 'package:data/mapper.dart';

class MovieMapper implements Mapper<String, List<Movie>> {
  @override
  List<Movie> transform(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();

    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}