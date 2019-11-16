import 'package:common/domain/use_case.dart';
import 'package:data/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:common/view/view_model.dart';

class ViewModelImpl<R, T>
    implements ViewModel<R, T>, ViewModelInput<R>, ViewModelOutput<T> {
  @override
  ViewModelInput<R> get inputs => this;

  @override
  ViewModelOutput<T> get outputs => this;

  @override
  Observable<bool> get loading => _loadingProperty.stream;

  @override
  Observable<Exception> get exception => _exceptionProperty.stream;

  @override
  Observable<T> get result {
    return _startProperty.stream
        .doOnData((_) => _loadingProperty.sink.add(true))
        .switchMap((request) => Observable.fromFuture(useCase.execute(request)))
        .onErrorReturnWith((error) => Error(Exception(error)))
        .flatMap((response) {
      return response.when((success) => Observable.just(success.value),
          (error) {
        _exceptionProperty.sink.add(error.error);

        return Observable.empty();
      });
    }).doOnData((_) => _loadingProperty.sink.add(false));
  }

  final UseCase<R, T> useCase;

  final _startProperty = BehaviorSubject<R>();
  final _loadingProperty = BehaviorSubject<bool>();
  final _exceptionProperty = BehaviorSubject<Exception>();

  ViewModelImpl({this.useCase});

  @override
  void start(R request) {
    _startProperty.sink.add(request);
  }

  @override
  void dispose() {
    _loadingProperty.close();
    _startProperty.close();
    _exceptionProperty.close();
  }
}
