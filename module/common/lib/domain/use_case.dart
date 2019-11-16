import 'package:data/result.dart';

abstract class UseCase<R, T> {
  Future<Result<T>> execute(R request, {bool forceCacheLoad = false});
}