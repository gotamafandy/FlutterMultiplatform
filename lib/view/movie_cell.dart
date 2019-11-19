import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/model/movie.dart';
import 'package:transparent_image/transparent_image.dart';

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
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: movie.poster.toString(),
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