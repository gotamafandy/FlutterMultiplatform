import 'package:common/domain/use_case.dart';
import 'package:data/result.dart';
import 'package:data/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:common/view/view_model_list.dart';
import 'package:tuple/tuple.dart';

class ViewModelListImpl<R, T extends DataList, E>
    implements
        ViewModelList<R, E>,
        ViewModelListInput<R>,
        ViewModelListOutput<R, E> {
  @override
  ViewModelListInput<R> get inputs => this;

  @override
  ViewModelListOutput<R, E> get outputs => this;

  @override
  Observable<bool> get loading => _loadingProperty.stream;

  @override
  Observable<Exception> get exception => _exceptionProperty.stream;

  @override
  Observable<Tuple2<R, List<E>>> result;

  final UseCase<R, T> useCase;
  final bool showCacheDuringInitialLoad;

  final _startProperty = BehaviorSubject<R>();
  final _loadMoreProperty = BehaviorSubject<R>();
  final _loadingProperty = BehaviorSubject<bool>();
  final _exceptionProperty = BehaviorSubject<Exception>();

  ViewModelListImpl({this.useCase, this.showCacheDuringInitialLoad}) {
    final items = List<E>();
    bool clearItems = false;

    Observable<Tuple2<R, T>> cacheRequest;

    if (showCacheDuringInitialLoad) {
      cacheRequest = _startProperty.stream
          .switchMap((request) => Observable.fromFuture(
                  useCase.execute(request, forceCacheLoad: true))
              .map((response) => Tuple2(request, response)))
          .flatMap((response) {
        return response.item2.when(
            (success) => Observable.just(Tuple2(response.item1, success.value)),
            (error) => Observable.empty());
      });
    } else {
      cacheRequest = null;
    }

    final initialRequest = _startProperty.stream
        .doOnData((_) => _loadingProperty.sink.add(true))
        .switchMap((request) => Observable.fromFuture(useCase.execute(request))
            .map((response) => Tuple2(request, response)))
        .flatMap((response) {
      return response.item2.when(
          (success) => Observable.just(Tuple2(response.item1, success.value)),
          (error) => Observable.empty());
    }).doOnData((_) {
      _loadingProperty.sink.add(false);
      clearItems = true;
    });

    final nextRequest = _loadMoreProperty.stream
        .doOnData((_) => _loadingProperty.sink.add(true))
        .switchMap((request) => Observable.fromFuture(useCase.execute(request))
            .map((response) => Tuple2(request, response)))
        .flatMap((response) {
      return response.item2.when(
          (success) => Observable.just(Tuple2(response.item1, success.value)),
          (error) => Observable.empty());
    }).doOnData((_) {
      _loadingProperty.sink.add(false);
      clearItems = false;
    });

    Tuple2<R, List<E>> getItems(Tuple2<R, T> response) {
      if (clearItems) {
        items.clear();
      }

      final list = response.item2.list as List<E>;

      items.addAll(list);

      return Tuple2(response.item1, items);
    }

    if (cacheRequest != null) {
      result = Observable.merge([cacheRequest, initialRequest, nextRequest])
          .map((response) {
        return getItems(response);
      });
    } else {
      result = Observable.merge([initialRequest, nextRequest]).map((response) {
        return getItems(response);
      });
    }
  }

  @override
  void start(R request) {
    _startProperty.sink.add(request);
  }

  @override
  void loadMore(R request) {
    _loadMoreProperty.sink.add(request);
  }

  @override
  void dispose() {
    _loadingProperty.close();
    _startProperty.close();
    _exceptionProperty.close();
  }
}
