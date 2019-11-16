import 'package:data/result.dart';

abstract class Service<R, T> {
  Future<Result<T>> execute(R request);
}