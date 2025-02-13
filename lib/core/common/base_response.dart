class BaseResponse<T> {
  T data;
  String message;
  String status;
  int? statusCode;
  int? currentPage;
  int? lastPage;

  BaseResponse({
    required this.data,
    this.message = "",
    this.status = "",
    this.statusCode,
    this.currentPage,
    this.lastPage,
  });
}
