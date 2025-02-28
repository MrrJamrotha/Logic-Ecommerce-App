import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/service/user_session_service.dart';
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

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
