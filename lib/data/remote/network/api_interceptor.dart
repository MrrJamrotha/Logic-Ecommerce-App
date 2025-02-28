import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/service/user_session_service.dart';

class ApiInterceptor {
  static Future<Map<String, String>> modifyHeaders() async {
    final session = di.get<UserSessionService>();

    String? token = await session.getToken();
    // print(token);
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }
}
