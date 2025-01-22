import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/user_model.dart';

abstract class UserRepository {
  Future<Result<UserModel, dynamic>> getUser({
    Map<String, dynamic>? parameters,
  });

  Future<Result<UserModel, dynamic>> updateUser({
    Map<String, dynamic>? parameters,
  });
}
