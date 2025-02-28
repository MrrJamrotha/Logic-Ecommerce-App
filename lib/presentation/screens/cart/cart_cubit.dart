import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/service/user_session_service.dart';
import 'package:foxShop/data/models/cart_model.dart';
import 'package:foxShop/data/models/product_cart_model.dart';
import 'package:foxShop/data/repositories/cart/cart_repository_impl.dart';
import 'package:foxShop/presentation/screens/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(isLoading: true));
  final userSessionService = di.get<UserSessionService>();
  final repos = di.get<CartRepositoryImpl>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      var user = await userSessionService.user;
      emit(state.copyWith(auth: user));
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getCarts() async {
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getCarts().then((response) {
        response.fold((failure) {
          showMessage(message: failure.message, status: MessageStatus.warning);
        }, (success) {
          emit(state.copyWith(
            productCarts: success,
            subTotal: response.subTotal,
            totalCart: response.totalCart,
            totalCommission: response.totalCommission,
            totalDiscount: response.totalDiscount,
            totalAmount: response.totalAmount,
          ));
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false));
      addError(error);
    }
  }

  Future<void> toggleCart({Map<String, dynamic>? parameters}) async {
    try {
      List<CartModel> carts = state.carts ?? [];
      List<ProductCartModel> productCarts = state.productCarts ?? [];
      // Check if the item is already in the wishlist
      final exists = carts.any((item) => item.id == parameters?['id']);

      if (exists) {
        // Remove from wishlist
        await repos.removeFromCart(parameters: parameters).then((response) {
          response.fold((failure) {
            showMessage(
              message: failure.message,
              status: MessageStatus.warning,
            );
            emit(state.copyWith(error: failure.message));
          }, (success) {
            carts.removeWhere((item) => item.id == parameters?['id']);
            productCarts = List.from(productCarts)
              ..removeWhere((item) => item.id == parameters?['id']);
            emit(state.copyWith(carts: carts,productCarts: productCarts));
            showMessage(message: response.message ?? "Removed from cart");
          });
        });
      } else {
        // Add to wishlist
        await repos.addToCart(parameters: parameters).then((response) {
          response.fold((failure) {
            showMessage(
              message: failure.message,
              status: MessageStatus.warning,
            );
            emit(state.copyWith(error: failure.message));
          }, (success) {
            carts.add(success);
            emit(state.copyWith(carts: List.from(carts)));
            showMessage(message: response.message ?? "Added to cart");
          });
        });
      }
    } catch (error) {
      addError(error);
    }
  }

  Future<void> removeFromCart({Map<String, dynamic>? parameters}) async {
    try {
      List<CartModel> carts = state.carts ?? [];
      List<ProductCartModel> productCarts = state.productCarts ?? [];

      await repos.removeFromCart(parameters: parameters).then((response) {
        response.fold((failure) {
          showMessage(
            message: failure.message,
            status: MessageStatus.warning,
          );
          emit(state.copyWith(error: failure.message));
        }, (success) {
          carts = List.from(carts)
            ..removeWhere((item) => item.id == parameters?['id']);
          productCarts = List.from(productCarts)
            ..removeWhere((item) => item.id == parameters?['id']);

          print('response.totalCart =${response.totalCart}');
          emit(
            state.copyWith(
              carts: carts,
              productCarts: productCarts,
              subTotal: response.subTotal,
              totalCart: response.totalCart,
              totalCommission: response.totalCommission,
              totalDiscount: response.totalDiscount,
              totalAmount: response.totalAmount,
            ),
          );
          showMessage(message: response.message ?? "Removed from cart");
        });
      });
    } catch (error) {
      addError(error);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
