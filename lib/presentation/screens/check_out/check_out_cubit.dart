import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutState(isLoading: true));

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      // TODO your code here

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }
}
