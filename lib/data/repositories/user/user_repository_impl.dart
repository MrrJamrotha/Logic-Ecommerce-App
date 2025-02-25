import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/models/user_model.dart';
import 'package:logic_app/data/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final _apiClient = di.get<ApiClient>();
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
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
