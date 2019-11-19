import 'package:angular_router/angular_router.dart';
import 'route_paths.dart';
import 'package:angular_app/src/movie_list_component.template.dart' as movie_list_template;
export 'route_paths.dart';

class Routes {
  static final movies = RouteDefinition(
    routePath: RoutePaths.movies,
    component: movie_list_template.MovieListComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    movies,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.movies.toUrl(),
    )
  ];
}