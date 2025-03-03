import 'package:foxShop/data/models/order_detail_model.dart';

class OrderDetailState {
  final bool isLoading;
  final String? error;
  final OrderDetailModel? record;
  const OrderDetailState({
    this.isLoading = false,
    this.error,
    this.record,
  });

  OrderDetailState copyWith({
    bool? isLoading,
    String? error,
    OrderDetailModel? record,
  }) {
    return OrderDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      record: record ?? this.record,
    );
  }
}
