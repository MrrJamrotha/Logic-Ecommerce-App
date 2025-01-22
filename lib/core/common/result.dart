class Result<T, E> {
  final T? success;
  final E? failed;

  Result({this.success, this.failed});
}
