import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_shared_preference_keys.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/shared_preferences_service.dart';
import 'package:logic_app/presentation/global/application/application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState());
  final _sharedPreferences = di.get<SharedPreferencesService>();

  Future<void> loadInitialData() async {
    try {
      final result = await _sharedPreferences.getBool(onBoradingKey) ?? false;
      emit(state.copyWith(onBoarding: result));
    } catch (e) {
      emit(state.copyWith(onBoarding: false));
      addError(e);
    }
  }

  Future<void> setOnboarding(bool value) async {
    try {
      await _sharedPreferences.setBool(onBoradingKey, value);
      emit(state.copyWith(onBoarding: value));
    } catch (e) {
      addError(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
