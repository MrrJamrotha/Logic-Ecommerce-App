import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/setting/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingState(isLoading: true));

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

  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
