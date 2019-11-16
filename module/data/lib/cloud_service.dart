import 'package:data/service.dart';
import 'package:data/result.dart';

abstract class CloudService<R, T> extends Service<R, T> {
  Result<T> parseResponse(T response) {

  }
}