import 'package:data/service.dart';
import 'package:data/result.dart';
import 'package:data/mapper.dart';
import 'package:http/http.dart';

class MovieCloudService<T> implements Service<String, T> {
  final String key;
  final String host;
  final Client client;
  final Mapper<String, T> mapper;

  const MovieCloudService({this.client, this.key, this.host, this.mapper});

  @override
  Future<Result<T>> execute(String request) async {
    final queries = {'apiKey': key, 's': request};
    final uri = Uri.https(host, '', queries);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return Success(mapper.transform(response.body));
    } else {
      return Error(Exception("Unable to get movie list"));
    }
  }
}
