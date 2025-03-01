import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/repositories/checkout/check_out_repository_impl.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutState(isLoading: true));
  final repos = di.get<CheckOutRepositoryImpl>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await getAddress();
      await getPaymentMethod();
      await getProductCarts();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getAddress() async {
    await repos.getAddress().then((response) {
      response.fold((failure) {
        showMessage(
          message: failure.message,
          status: MessageStatus.warning,
        );
        emit(state.copyWith(error: failure.message));
      }, (success) {
        emit(state.copyWith(addresses: success));
      });
    });
  }

  Future<void> getPaymentMethod() async {
    await repos.getPaymentMethod().then((response) {
      response.fold((failure) {
        showMessage(
          message: failure.message,
          status: MessageStatus.warning,
        );
        emit(state.copyWith(error: failure.message));
      }, (success) {
        emit(state.copyWith(paymentMethods: success));
      });
    });
  }

  Future<void> getProductCarts() async {
    await repos.getProductCarts().then((response) {
      response.fold((failure) {
        showMessage(
          message: failure.message,
          status: MessageStatus.warning,
        );
        emit(state.copyWith(error: failure.message));
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
  }

  void selectPaymentMethod(String code) {
    emit(state.copyWith(selectPaymentMethodCode: code));
  }
}
