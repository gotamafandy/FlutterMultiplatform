import 'repository.dart';
import 'package:data/result.dart';
import 'package:data/service.dart';

class RepositoryImpl<R, T> implements Repository<R, T> {

  final Service<R, T> service;

  const RepositoryImpl({this.service});

  @override
  Future<Result<T>> get(R request, bool forceCacheLoad) async {
    return await service.execute(request);
  }
}