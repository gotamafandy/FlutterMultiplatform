import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/http.dart' as http;

import 'src/routes.dart';

const key = OpaqueToken<String>('key');
const host = OpaqueToken<String>('host');

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [routerDirectives],
  exports: [RoutePaths, Routes],
  providers: [
    ClassProvider(http.Client),
    ValueProvider.forToken(key, "b445ca0b"),
    ValueProvider.forToken(host, "www.omdbapi.com"),
  ],
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css'
  ]
)
class AppComponent {
  var name = 'Flutter & AngularDart code sharing';
}
