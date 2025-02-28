import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/user_model.dart';

abstract class UserRepository {
  Future<Result<UserModel, Failure>> getUserProfile({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> updateUserProfile({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> changeLocale({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> changeCurrencyCode({
    Map<String, dynamic>? parameters,
  });
}
