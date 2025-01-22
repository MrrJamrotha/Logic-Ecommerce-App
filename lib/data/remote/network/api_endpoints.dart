class ApiEndpoints {
  static const String baseUrl = "";

  //Auth
  static const login = '$baseUrl/login';
  static const register = '$baseUrl/register';
  static const forgotPassword = '$baseUrl/forgot-password';
  static const resetPassword = '$baseUrl/reset-password';

  //User
  static const getUserProfile = '$baseUrl/user/profile';
  static const updateUserProfile = '$baseUrl/user/profile/update';
  static const getUserDetails = '$baseUrl/user/details';
}
