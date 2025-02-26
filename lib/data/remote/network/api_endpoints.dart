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

  static final getProductByCategory = '$baseUrl/get-product-by-category';
  static final getProductByBrand = '$baseUrl/get-product-by-brand';
  static final getItemDetail = '$baseUrl/get-item-detail';

  //Merchant
  static final getMerchntProfile = '$baseUrl/get-merchant-profile';
  static final getProductByMerchnt = '$baseUrl/get-product-by-merchant';

  //Auth
  static final generateOtpCode = '$baseUrl/generate-otp-code';
  static final verifyOTP = '$baseUrl/verify-otp-code';
  static final forgotPassword = '$baseUrl/forgot-password';
  static final resetPassword = '$baseUrl/reset-password';
  static final loginWithGoogle = '$baseUrl/login-with-google';

  //User
  static final getUserProfile = '$baseUrl/profile/get-user-profile';

  //Address
  static final getUserAddress = '$baseUrl/address/get-address-by-user';
  static final getAddressById = '$baseUrl/address/get-address-by-id';
  static final createAddress = '$baseUrl/address/create-address';
  static final updateAddress = '$baseUrl/address/update-address';
  static final deleteAddress = '$baseUrl/address/delete-address';
  static final setDefaultAddress = '$baseUrl/address/set-default-address';
}
