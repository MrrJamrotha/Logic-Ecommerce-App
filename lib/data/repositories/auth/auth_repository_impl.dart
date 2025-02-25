import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/data/models/user_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _apiClient = di.get<ApiClient>();
  final _session = di.get<UserSessionService>();
  @override
  Future<Result<String, dynamic>> generateOtpCode({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.generateOtpCode(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      return Result.right(
        result.status,
        message: result.message,
      );
    } catch (error) {
      return Result.left(error);
    }
  }

  @override
  Future<Result<UserModel, dynamic>> verifyOtp({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.verifyOTP(parameters: parameters);

      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      final record = UserModel.fromJson(result.data);
      await _session.storeUser(record);

      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(error);
    }
  }
}
