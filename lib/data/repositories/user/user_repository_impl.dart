import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/models/user_model.dart';
import 'package:logic_app/data/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final _apiClient = di.get<ApiClient>();
  final _session = di.get<UserSessionService>();
  @override
  Future<Result<UserModel, Failure>> getUserProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getUserProfile(parameters: parameters);
      if (result.statusCode != 200) {
        return Result.left(Failure(result.message));
      }
      final record = UserModel.fromJson(result.data);
      await _session.storeUser(record);
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<UserModel, Failure>> updateUserProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.updateUserProfile(parameters: parameters);
      if (result.statusCode != 200) {
        return Result.left(Failure(result.message));
      }
      final record = UserModel.fromJson(result.data);
      await _session.storeUser(record);
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
