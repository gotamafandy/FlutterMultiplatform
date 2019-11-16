import 'package:rxdart/rxdart.dart';

abstract class ViewModelInput<R> {
  void start(R request);
}

abstract class ViewModelOutput<T> {
  Observable<bool> get loading;
  Observable<T> get result;
  Observable<Exception> get exception;
}

abstract class ViewModel<R, T> {
  ViewModelInput<R> get inputs;
  ViewModelOutput<T> get outputs;

  void dispose();
}