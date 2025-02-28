import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/locale/locale_manager.dart';
import 'package:logic_app/presentation/global/application/application_state.dart';

class ApplicationCubit extends HydratedCubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState()) {
    localeManager.setLocale(getLocale(state.localeCode ?? "en"));
  }
  final localeManager = di.get<LocaleManager>();
  // final _sharedPreferences = di.get<SharedPreferencesService>();

  Future<void> loadInitialData() async {
    // try {
    //   final result = await _sharedPreferences.getBool(onBoradingKey) ?? false;
    //   emit(state.copyWith(onBoarding: result));
    // } catch (e) {
    //   emit(state.copyWith(onBoarding: false));
    //   addError(e);
    // }
  }

  Future<void> setOnboarding(bool value) async {
    try {
      // await _sharedPreferences.setBool(onBoradingKey, value);
      emit(state.copyWith(onBoarding: value));
    } catch (e) {
      addError(e);
    }
  }

  Future<void> changeLocale(String localeCode) async {
    try {
      localeManager.setLocale(getLocale(localeCode));
      emit(state.copyWith(localeCode: localeCode));
    } catch (e) {
      addError(e);
    }
  }

  Future<void> changeCurrencyCode (String code) async{ 
    try {
      emit(state.copyWith(currencyCode: code));
    } catch (e) {
      addError(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  @override
  ApplicationState? fromJson(Map<String, dynamic> json) {
    try {
      return ApplicationState.fromJson(json);
    } catch (e) {
      addError(e);
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ApplicationState state) {
    try {
      return state.toJson();
    } catch (e) {
      addError(e);
      return null;
    }
  }
}
