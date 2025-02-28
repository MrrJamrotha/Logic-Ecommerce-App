import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/setting/setting_state.dart';

class SettingCubit extends HydratedCubit<SettingState> {
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

  @override
  SettingState? fromJson(Map<String, dynamic> json) {
    return SettingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingState state) {
    try {
      return state.toJson();
    } catch (error) {
      addError(error);
      return null;
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
