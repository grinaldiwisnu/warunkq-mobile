class ApiResponse<T> {
  final T? result;
  final int? status;
  final String? message;

  ApiResponse({this.result, this.status, this.message});
}
