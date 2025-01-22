class ApiInterceptor {
  static Map<String, String> modifyHeaders({String? token}) {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }
}
