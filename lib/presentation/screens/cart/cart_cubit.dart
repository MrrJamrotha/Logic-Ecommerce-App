import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/presentation/screens/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(isLoading: true));
  final userSessionService = di.get<UserSessionService>();
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
}
