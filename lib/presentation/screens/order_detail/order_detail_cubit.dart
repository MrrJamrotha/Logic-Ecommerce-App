import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/repositories/order/order_repository_impl.dart';
import 'package:foxShop/presentation/screens/order_detail/order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailState(isLoading: true));
  final repos = di.get<OrderRepositoryImpl>();
  Future<void> loadInitialData({Map<String, dynamic>? parameters}) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getOrderDetail(parameters: parameters).then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.toString()));
          showMessage(message: failure.message, status: MessageStatus.warning);
        }, (success) {
          emit(stableState.copyWith(record: success));
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }
}
