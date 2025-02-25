import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/auth/auth_repository_impl.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState(isLoading: false));
  final repos = di.get<AuthRepositoryImpl>();

  Future<bool> verifyOtp({Map<String, dynamic>? parameters}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await repos.verifyOtp(parameters: parameters);

      response.fold((failure) {
        final failure = response.failed as Failure;
        emit(state.copyWith(
          message: failure.message,
          isLoading: false,
        ));
        showMessage(
          message: response.message ?? "",
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
    } catch (error) {
      emit(
        state.copyWith(
          error: error.toString(),
          isLoading: false,
          message: error.toString(),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
