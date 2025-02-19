import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/models/user_model.dart';
import 'package:logic_app/data/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<UserModel, dynamic>> getUser({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getUser(parameters: parameters);
      if (result.statusCode != 200) {
        return Result(failed: result.message);
      }
      return Result(success: result.data);
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }

  @override
  Future<Result<UserModel, dynamic>> updateUser({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.updateUser(parameters: parameters);
      if (result.statusCode != 200) {
        return Result(failed: result.message);
      }
      return Result(success: result.data);
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }
}
