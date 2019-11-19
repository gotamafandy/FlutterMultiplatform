import 'package:common/domain/use_case_impl.dart';
import 'package:common/view/view_model_list_impl.dart';
import 'package:common/repository/repository_impl.dart';

import 'package:data/model.dart';

import 'package:movie/model/movie.dart';
import 'package:movie/movie_cloud_service.dart';
import 'package:movie/model/movie_mapper.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'view/movie_list.dart';

class App extends StatelessWidget {
  final client = Client();

  get movieViewModel {
    final mapper = MovieMapper();
    final service = MovieCloudService(
        client: client,
        key: "b445ca0b",
        host: "www.omdbapi.com",
        mapper: mapper);
    final repository = RepositoryImpl(service: service);
    final useCase = UseCaseImpl(repository: repository);
    return ViewModelListImpl<String, DataList<Movie>, Movie>(useCase: useCase, showCacheDuringInitialLoad: false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: MovieList(viewModel: movieViewModel),
      ),
    );
  }
}
