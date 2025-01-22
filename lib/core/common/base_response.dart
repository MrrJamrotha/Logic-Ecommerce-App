class BaseResponse<T> {
  T data;
  String message;
  String status;
  int? statusCode;

  BaseResponse({
    required this.data,
    this.message = "",
    this.status = "",
    this.statusCode,
  });
}
