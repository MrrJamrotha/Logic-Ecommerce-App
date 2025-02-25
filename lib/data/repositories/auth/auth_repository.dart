import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Result<String, Failure>> generateOtpCode({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> verifyOtp({
    Map<String, dynamic>? parameters,
  });
}
