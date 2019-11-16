import 'package:flutter/material.dart';
import 'package:common/view/view_model_list.dart';
import 'package:flutter_clean_architecture/view/movie_cell.dart';
import 'package:movie/model/movie.dart';
import 'package:data/model.dart';
import 'package:tuple/tuple.dart';

class MovieList extends StatefulWidget {
  final ViewModelList<String, Movie> viewModel;

  const MovieList({Key key, this.viewModel}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    widget.viewModel.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: StreamBuilder(
          stream: widget.viewModel.outputs.result,
          builder: (context, AsyncSnapshot<Tuple2<String, List<Movie>>> snapshot) {
            if (snapshot.data == null) return Container();

            final list = snapshot.data.item2;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.7),
              itemCount: list.length,
              itemBuilder: (context, index) {
                if (index == list.length - 2) {
                  widget.viewModel.inputs.loadMore("avenger");
                }

                return MovieCell(movie: list[index]);
              },
            );
          }),
    );
  }

  Future<Null> _refresh() async {
    widget.viewModel.inputs.start("avenger");

    return null;
  }
}
