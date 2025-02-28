import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/repositories/auth/auth_repository_impl.dart';
import 'package:foxShop/presentation/screens/auth/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState(isLoading: false));
  final repos = di.get<AuthRepositoryImpl>();

  Future<bool> verifyOtp({Map<String, dynamic>? parameters}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await repos.verifyOtp(parameters: parameters);
      final result = response.fold((failure) {
        emit(state.copyWith(
          message: failure.message,
          isLoading: false,
        ));

        return false;
      }, (success) {
        emit(state.copyWith(
          user: success,
          message: response.message,
          isLoading: false,
        ));

        return true;
      });
      return result;
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
