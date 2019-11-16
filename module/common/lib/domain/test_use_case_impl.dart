import 'use_case.dart';
import 'package:data/result.dart';

class TestUseCaseImpl<R> implements UseCase<R, String> {
  @override
  Future<Result<String>> execute(R request, {bool forceCacheLoad = false}) async {
    return Success("Success");
  }
}