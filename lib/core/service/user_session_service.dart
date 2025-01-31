import 'dart:convert';

import 'package:logic_app/core/di/injection.dart';
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

  Future<void> storeUser(UserModel record) async {
    String userJson = jsonEncode(record.toJson());
    await _secureStorageService.write('user', userJson);
  }

  Future<UserModel?> getUser() async {
    // Instance method
    String? userJson = await _secureStorageService.read('user');
    if (userJson != null) {
      // Assuming UserModel has a fromJson method
      userModel = UserModel.fromJon(jsonDecode(userJson));
    }
    return userModel;
  }
}
