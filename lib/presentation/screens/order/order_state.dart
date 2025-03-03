import 'package:foxShop/data/models/order_model.dart';

class OrderState {
  final bool isLoading;
  final String? error;
  final List<OrderModel>? records;
  final int currentPage;
  final int lastPage;

  const OrderState({
    this.isLoading = false,
    this.error,
    this.records,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  OrderState copyWith({
    bool? isLoading,
    String? error,
    List<OrderModel>? records,
    int? currentPage,
    int? lastPage,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
