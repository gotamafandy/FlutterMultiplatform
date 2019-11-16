import 'package:flutter/material.dart';
import 'package:common/view/view_model.dart';

class MovieList extends StatefulWidget {
  final ViewModel<String, String> viewModel;

  const MovieList({Key key, this.viewModel}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void dispose() {
    widget.viewModel.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.viewModel.inputs.start("");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          StreamBuilder(stream: widget.viewModel.outputs.loading, builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == null) return Container();

            return Text(snapshot.data ? 'Loading' : 'Not Loading');
          }),
          StreamBuilder(stream: widget.viewModel.outputs.result, builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.data == null) return Container();

            return Text(snapshot.data);
          }),
        ],
      ),
    );
  }
}
