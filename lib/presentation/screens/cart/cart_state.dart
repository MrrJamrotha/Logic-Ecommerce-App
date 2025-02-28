import 'package:foxShop/data/models/cart_model.dart';
import 'package:foxShop/data/models/product_cart_model.dart';
import 'package:foxShop/data/models/user_model.dart';

class CartState {
  final bool isLoading;
  final String? error;
  final UserModel? auth;
  final CartModel? cartModel;
  final String? subTotal;
  final String? totalCommission;
  final String? totalDiscount;
  final String? totalCart;
  final String? totalAmount;
  final List<ProductCartModel>? productCarts;

  const CartState({
    this.isLoading = false,
    this.error,
    this.auth,
    this.cartModel,
    this.subTotal,
    this.totalCommission,
    this.totalDiscount,
    this.totalCart,
    this.totalAmount,
    this.productCarts,
  });

  CartState copyWith({
    bool? isLoading,
    String? error,
    UserModel? auth,
    CartModel? cartModel,
    String? subTotal,
    String? totalCommission,
    String? totalDiscount,
    String? totalCart,
    String? totalAmount,
    List<ProductCartModel>? productCarts,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      auth: auth ?? this.auth,
      cartModel: cartModel ?? this.cartModel,
      subTotal: subTotal ?? this.subTotal,
      totalCommission: totalCommission ?? this.totalCommission,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      totalCart: totalCart ?? this.totalCart,
      totalAmount: totalAmount ?? this.totalAmount,
      productCarts: productCarts ?? this.productCarts,
    );
  }
}
