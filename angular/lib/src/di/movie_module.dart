import 'package:angular_app/app_component.dart';

import 'package:common/domain/use_case_impl.dart';

import 'package:common/repository/repository_impl.dart';
import 'package:common/view/view_model_list_impl.dart';
import 'package:common/view/view_model_list.dart';
import 'package:data/mapper.dart';
import 'package:common/repository/repository.dart';
import 'package:common/domain/use_case.dart';

import 'package:data/model.dart';
import 'package:data/service.dart';

import 'package:movie/model/movie.dart';
import 'package:movie/movie_cloud_service.dart';

import 'package:http/http.dart' as http;

Service<String, DataList<Movie>> provideService(http.Client client, @key String key, @host String host, Mapper mapper) {
  return MovieCloudService(client: client, key: key, host: host, mapper: mapper);
}

Repository<String, DataList<Movie>> provideRepository(Service service) {
  return RepositoryImpl(service: service);
}

UseCase<String, DataList<Movie>> provideUseCase(Repository repository) {
  return UseCaseImpl(repository: repository);
}

ViewModelList<String, Movie> provideViewModel(UseCase useCase) {
  return ViewModelListImpl<String, DataList<Movie>, Movie>(useCase: useCase, showCacheDuringInitialLoad: false);
}
