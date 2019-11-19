
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:angular/core.dart';

mixin DisposableMixin implements OnDestroy {
  @protected
  final List<StreamSubscription> disposables = [];

   void ngOnDestroy () {
    for (final disposable in disposables) disposable.cancel();
  }
}