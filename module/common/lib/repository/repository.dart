import 'package:data/result.dart';

abstract class Repository<R, T> {
  Future<Result<T>> get(R request, bool forceCacheReload);
}