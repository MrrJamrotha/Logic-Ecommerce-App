import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Result<String, Failure>> generateOtpCode({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> verifyOtp({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> loginWithGoogle({
    Map<String, dynamic>? parameters,
  });
}
