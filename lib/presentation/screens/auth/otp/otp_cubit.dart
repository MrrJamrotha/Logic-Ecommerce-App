import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/auth/auth_repository_impl.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState(isLoading: false));
  final repos = di.get<AuthRepositoryImpl>();

  Future<bool> verifyOtp({Map<String, dynamic>? parameters}) async {
    emit(state.copyWith(isLoading: true));
    await repos.verifyOtp(parameters: parameters).then((response) {
      response.fold((failure) {
        final failure = response.failed;
        emit(state.copyWith(
          message: failure?.message,
          isLoading: false,
        ));
        showMessage(
          message: failure?.message ?? "",
          status: MessageStatus.warning,
        );
        return false;
      }, (success) {
        emit(state.copyWith(
          user: success,
          message: response.message,
          isLoading: false,
        ));
        showMessage(
          message: response.message ?? "",
          status: MessageStatus.success,
        );
        return true;
      });
    });
    return false;
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
