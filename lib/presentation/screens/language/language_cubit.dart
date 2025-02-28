import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/user/user_repository_impl.dart';
import 'package:logic_app/presentation/screens/language/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(isLoading: true));
  final repos = di.get<UserRepositoryImpl>();

  Future<void> getUserProfile() async {
    try {} catch (e) {
      addError(e);
    }
  }

  Future<bool> changeLocale(String localeCode) async {
    try {
      await repos
          .changeLocale(parameters: {'locale': localeCode}).then((response) {
        response.fold((failure) {
          showMessage(message: failure.message, status: MessageStatus.warning);
          emit(state.copyWith(errorMessage: failure.message));
          return false;
        }, (success) {
          emit(state.copyWith(record: success));
          return true;
        });
      });
      return true;
    } catch (e) {
      addError(e);
      return false;
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
