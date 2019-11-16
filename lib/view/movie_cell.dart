import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/model/movie.dart';

class MovieCell extends StatelessWidget {
  final Movie movie;

  MovieCell({Key key, this.movie}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.network(
                movie.poster.toString(),
                fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child:  Text(movie.title, textAlign: TextAlign.center),
          )

        ],
      ),
    );

  }
}