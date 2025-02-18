class BaseResponse<T> {
  T data;
  String message;
  String status;
  int? statusCode;
  int currentPage;
  int lastPage;
  T? data2;

  BaseResponse({
    required this.data,
    this.message = "",
    this.status = "",
    this.statusCode,
    this.currentPage = 1,
    this.lastPage = 1,
    this.data2,
  });
}
