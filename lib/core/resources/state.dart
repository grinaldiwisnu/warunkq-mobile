abstract class DataState<T> {
  final T success;
  final String error;

  const DataState({this.success, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(success: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String error) : super(error: error);
}
