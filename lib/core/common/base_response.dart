class BaseResponse<T> {
  T data;
  String message;
  String status;
  int? statusCode;
  int currentPage;
  int lastPage;
  T? categories;
  T? brands;
  T? priceRange;
  String? subTotal;
  String? totalCommission;
  String? totalDiscount;
  String? totalCart;
  String? totalAmount;

  BaseResponse({
    required this.data,
    this.message = "",
    this.status = "",
    this.statusCode,
    this.currentPage = 1,
    this.lastPage = 1,
    this.categories,
    this.brands,
    this.priceRange,
    this.subTotal,
    this.totalCommission,
    this.totalDiscount,
    this.totalCart,
    this.totalAmount,
  });
}
