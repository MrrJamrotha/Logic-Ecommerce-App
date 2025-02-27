import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/user_model.dart';

abstract class UserRepository {
  Future<Result<UserModel, Failure>> getUserProfile({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, Failure>> updateUserProfile({
    Map<String, dynamic>? parameters,
  });
}
