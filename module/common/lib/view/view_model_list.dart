import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

abstract class ViewModelListInput<R> {
  void start(R request);
  void loadMore(R request);
}

abstract class ViewModelListOutput<R, T> {
  Observable<bool> get loading;
  Observable<Tuple2<R, List<T>>> get result;
  Observable<Exception> get exception;
}

abstract class ViewModelList<R, T> {
  ViewModelListInput<R> get inputs;
  ViewModelListOutput<R, T> get outputs;

  void dispose();
}