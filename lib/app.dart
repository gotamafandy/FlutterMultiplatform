import 'package:common/view/view_model_impl.dart';
import 'package:common/domain/test_use_case_impl.dart';
import 'view/movie_list.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final useCase = TestUseCaseImpl<String>();
    final viewModel = ViewModelImpl<String, String>(useCase: useCase);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: MovieList(viewModel: viewModel),
      ),
    );
  }
}

