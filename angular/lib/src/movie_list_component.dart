import 'package:angular/angular.dart';
import 'package:angular_app/src/disposable.dart';

import 'package:common/view/view_model_list.dart';
import 'package:data/mapper.dart';
import 'package:common/repository/repository.dart';
import 'package:common/domain/use_case.dart';

import 'package:data/service.dart';

import 'package:movie/model/movie_mapper.dart';
import 'di/movie_module.dart';
import 'package:movie/model/movie.dart';

@Component(
  selector: 'my-movies',
  templateUrl: 'movie_list_component.html',
  directives: [coreDirectives],
  providers: [
    ClassProvider(Mapper, useClass: MovieMapper),
    FactoryProvider(Service, provideService),
    FactoryProvider(Repository, provideRepository),
    FactoryProvider(UseCase, provideUseCase),
    FactoryProvider(ViewModelList, provideViewModel),
  ],
  styleUrls: [
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
    'movie_list_component.css',
  ]
)
class MovieListComponent with DisposableMixin implements OnInit, OnDestroy {
  MovieListComponent(this.viewModel);
  
  final ViewModelList viewModel;
  
  List<Movie> movies;
  bool loading;

  void ngOnInit() {
    disposables.add(viewModel.outputs.result.listen((data) => movies = data.item2));

    viewModel.inputs.start('avenger');
  }

  @override
  void ngOnDestroy() {
    super.ngOnDestroy();
  }
}
