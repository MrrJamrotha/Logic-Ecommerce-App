import 'package:foxShop/data/models/address_model.dart';
import 'package:foxShop/data/models/payment_method_model.dart';
import 'package:foxShop/data/models/product_cart_model.dart';

class CheckOutState {
  final bool isLoading;
  final String? error;
  final List<PaymentMethodModel>? paymentMethods;
  final String? selectPaymentMethodCode;
  final List<AddressModel>? addresses;

  final String? subTotal;
  final String? totalCommission;
  final String? totalDiscount;
  final String? totalCart;
  final String? totalAmount;
  final List<ProductCartModel>? productCarts;

  const CheckOutState({
    this.isLoading = false,
    this.error,
    this.paymentMethods,
    this.selectPaymentMethodCode = '',
    this.addresses,
    this.subTotal,
    this.totalCommission,
    this.totalDiscount,
    this.totalCart,
    this.totalAmount,
    this.productCarts,
  });

  CheckOutState copyWith({
    bool? isLoading,
    String? error,
    List<PaymentMethodModel>? paymentMethods,
    String? selectPaymentMethodCode,
    List<AddressModel>? addresses,
    String? subTotal,
    String? totalCommission,
    String? totalDiscount,
    String? totalCart,
    String? totalAmount,
    List<ProductCartModel>? productCarts,
  }) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectPaymentMethodCode:
          selectPaymentMethodCode ?? this.selectPaymentMethodCode,
      addresses: addresses ?? this.addresses,
      subTotal: subTotal ?? this.subTotal,
      totalCommission: totalCommission ?? this.totalCommission,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      totalCart: totalCart ?? this.totalCart,
      totalAmount: totalAmount ?? this.totalAmount,
      productCarts: productCarts ?? this.productCarts,
    );
  }
}
