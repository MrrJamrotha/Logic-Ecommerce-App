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

  Future<void> setDefaultAddress(String id) async {
    try {
      await repos.setDefaultAddress(parameters: {'id': id}).then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.toString()));
          showMessage(message: failure.message, status: MessageStatus.warning);
        }, (success) {
          var records = state.addresses ?? [];

          // Update the records: set selected address to true, others to false
          records = records.map((item) {
            return item.copyWith(isDefault: item.id == id);
          }).toList();

          emit(state.copyWith(addresses: records));

          showMessage(message: response.message ?? "");
        });
      });
    } catch (e) {
      addError(e);
    }
  }

  Future<bool> placeOrder({Map<String, dynamic>? parameters}) async {
    try {
      final response = await repos.placeOrder(parameters: parameters);
      bool isSuccess = false;
      response.fold((failure) {
        emit(state.copyWith(error: failure.toString()));
        showMessage(message: failure.message, status: MessageStatus.warning);
        isSuccess = false;
      }, (success) {
        showMessage(message: response.message ?? "");
        isSuccess = true;
      });
      return isSuccess;
    } catch (e) {
      addError(e);
      return false;
    }
  }

  void selectPaymentMethod(String code) {
    emit(state.copyWith(selectPaymentMethodCode: code));
  }
}
