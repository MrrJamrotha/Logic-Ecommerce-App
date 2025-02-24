import 'dart:convert';

import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/secure_storage_service.dart';
import 'package:logic_app/data/models/user_model.dart';

class UserSessionService {
  static final UserSessionService _instance = UserSessionService._internal();
  final _secureStorageService = di.get<SecureStorageService>();

  UserSessionService._internal();
  static UserSessionService get instance => _instance;

  factory UserSessionService() {
    return _instance;
  }

  UserModel? userModel;

  Future<UserModel?> get user async {
    if (userModel != null) return userModel!;
    return await getUser();
  }

  Future<void> logout() async {
    userModel = null;
    await _secureStorageService.delete('user');
    await _secureStorageService.delete('jwt');
  }

  Future<void> storeUser(UserModel record) async {
    String userJson = jsonEncode(record.toJson());
    await _secureStorageService.write('user', userJson);
  }

  Future<void> storeToken(String token) async {
    await _secureStorageService.write('jwt', token);
  }

  Future<String?> getToken() async {
    return await _secureStorageService.read('jwt');
  }

  Future<UserModel?> getUser() async {
    try {
      String? userJson = await _secureStorageService.read('user');
      if (userJson != null) {
        userModel = UserModel.fromJson(jsonDecode(userJson));
        return userModel;
      }
      return null;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
