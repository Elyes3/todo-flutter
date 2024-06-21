class Result<T> {
  final T? data;
  final String? error;
  final String? message;
  Result({this.data, this.error, this.message});
  bool get isFailed => error != null;
}
