import 'use_case.dart';
import 'package:data/result.dart';
import 'package:common/repository/repository.dart';

class UseCaseImpl<R, T> implements UseCase<R, T> {
  final Repository<R, T> repository;

  const UseCaseImpl({this.repository});

  @override
  Future<Result<T>> execute(R request, {bool forceCacheLoad = false}) async {
    return await repository.get(request, forceCacheLoad);
  }
}