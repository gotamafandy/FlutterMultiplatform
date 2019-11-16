import 'dart:convert';

import 'package:movie/model/movie.dart';
import 'package:data/mapper.dart';
import 'package:data/model.dart';

class MovieMapper implements Mapper<String, DataList<Movie>> {
  @override
  DataList<Movie> transform(String response) {
    final parsed = json.decode(response);

    final list = parsed['Search'] as List;

    return DataList(list: list.map<Movie>((json) => Movie.fromJson(json)).toList());
  }
}