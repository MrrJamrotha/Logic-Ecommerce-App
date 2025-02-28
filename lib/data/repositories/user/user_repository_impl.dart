import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/core/service/user_session_service.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/models/user_model.dart';
import 'package:foxShop/data/repositories/user/user_repository.dart';

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

  @override
  Future<Result<UserModel, Failure>> changeCurrencyCode({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.changeCurrencyCode(parameters: parameters);
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
  Future<Result<UserModel, Failure>> changeLocale({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.changeLocale(parameters: parameters);
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
