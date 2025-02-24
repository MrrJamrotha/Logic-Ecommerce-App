import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Result<String, dynamic>> generateOtpCode({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, dynamic>> verifyOtp({
    Map<String, dynamic>? parameters,
  });
}
