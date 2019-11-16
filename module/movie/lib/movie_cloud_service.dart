import 'package:data/service.dart';
import 'package:data/result.dart';
import 'package:data/result.dart';
import 'package:data/mapper.dart';

import 'package:movie/model/movie.dart';
import 'package:http/http.dart';

import 'dart:convert';

class FetchMovies<T> implements Service<String, T> {
  final String key;
  final String host;
  final Client client;
  final Mapper<String, T> mapper;

  const FetchMovies({this.client, this.key, this.host, this.mapper});

  @override
  Future<Result<T>> execute(String request) async {
    final response = await client.get(host);

    if (response.statusCode == 200) {
      return Success(mapper.transform(response.body));
    }
  }
}
