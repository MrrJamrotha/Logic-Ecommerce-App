import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl = dotenv.env['baseUrl'] ?? "";

  //Home
  static final getSlideShow = '$baseUrl/get-slide-show';
  static final getBrowseCategories = '$baseUrl/get-categories';
  static final getBrands = '$baseUrl/get-brands';

  static final getRecommendedForYou = '$baseUrl/get-product-recommended';
  static final getNewArrivals = '$baseUrl/get-product-new-arrivals';
  static final getRelatedProduct = '$baseUrl/get-product-related';
  static final getProductBastReview = '$baseUrl/get-product-bast-review';
  static final getSpacialProduct = '$baseUrl/get-product-spacial';

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
