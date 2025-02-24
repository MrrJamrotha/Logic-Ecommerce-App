import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/service/user_session_service.dart';

class ApiInterceptor {
  static Future<Map<String, String>> modifyHeaders({String? token}) async {
    final session = di.get<UserSessionService>();

    String? token = await session.getToken();

    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }
}
