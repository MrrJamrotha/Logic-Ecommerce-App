import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl = dotenv.env['baseUrl'] ?? "";

  //Home
  static final getSlideShow = '$baseUrl/get-slide-show';
  static final getBrowseCategories = '$baseUrl/get-browse-categories';
  static final getBrands = '$baseUrl/get-brands';

  //Auth
  static final login = '$baseUrl/login';
  static final register = '$baseUrl/register';
  static final forgotPassword = '$baseUrl/forgot-password';
  static final resetPassword = '$baseUrl/reset-password';

  //User
  static final getUserProfile = '$baseUrl/user/profile';
  static final updateUserProfile = '$baseUrl/user/profile/update';
  static final getUserDetails = '$baseUrl/user/details';
}
