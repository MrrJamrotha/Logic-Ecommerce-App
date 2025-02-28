import 'package:foxShop/core/utils/app_format.dart';

class UserModel {
  final String id;
  final String email;
  final String googleId;
  final String username;
  final String avatar;
  final String sessionToken;
  final String avatarHash;
  final String phoneNumber;
  final String locale;
  final String currencyCode;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.sessionToken,
    required this.avatarHash,
    required this.phoneNumber,
    required this.googleId,
    required this.locale,
    required this.currencyCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar': avatar,
      'session_token': sessionToken,
      'avatar_hash': avatarHash,
      'phone_number': phoneNumber,
      'google_id': googleId,
      'email': email,
      'locale': locale,
      'currency_code': currencyCode,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: AppFormat.toStr(map['id']),
      username: AppFormat.toStr(map['username']),
      avatar: AppFormat.toStr(map['avatar']),
      sessionToken: AppFormat.toStr(map['session_token']),
      avatarHash: AppFormat.toStr(map['avatar_hash']),
      phoneNumber: AppFormat.toStr(map['phone_number']),
      googleId: AppFormat.toStr(map['google_id']),
      email: AppFormat.toStr(map['email']),
      locale: AppFormat.toStr(map['locale']),
      currencyCode: AppFormat.toStr(map['currency_code']),
    );
  }
}
