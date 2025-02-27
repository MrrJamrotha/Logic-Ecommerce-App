import 'package:logic_app/core/common/base_response.dart';

abstract class Api {
  //Authentication
  Future<BaseResponse> generateOtpCode({Map<String, dynamic>? parameters});
  Future<BaseResponse> verifyOTP({Map<String, dynamic>? parameters});
  Future<BaseResponse> loginWithGoogle({Map<String, dynamic>? parameters});

  //User
  Future<BaseResponse> getUserProfile({Map<String, dynamic>? parameters});
  Future<BaseResponse> updateUserProfile({Map<String, dynamic>? parameters});

  //Home
  Future<BaseResponse> getSlideShow({Map<String, dynamic>? parameters});
  Future<BaseResponse> getBrowseCategories({Map<String, dynamic>? parameters});
  Future<BaseResponse> getBrands({Map<String, dynamic>? parameters});
  Future<BaseResponse> getRecommendForYou({Map<String, dynamic>? parameters});
  Future<BaseResponse> getProductNewArrivals({
    Map<String, dynamic>? parameters,
  });

  Future<BaseResponse> getSpacialProduct({Map<String, dynamic>? parameters});
  Future<BaseResponse> getProductBastReview({Map<String, dynamic>? parameters});
  Future<BaseResponse> getRelatedProduct({Map<String, dynamic>? parameters});

  Future<BaseResponse> getMerchantProfile({Map<String, dynamic>? parameters});
  Future<BaseResponse> getProductByMerchnat({Map<String, dynamic>? parameters});

  Future<BaseResponse> getProductByCategory({Map<String, dynamic>? parameters});
  Future<BaseResponse> getProductByBrand({Map<String, dynamic>? parameters});
  Future<BaseResponse> getItemDetail({Map<String, dynamic>? parameters});

  //Address
  Future<BaseResponse> getUserAddress({Map<String, dynamic>? parameters});
  Future<BaseResponse> getAddressById({Map<String, dynamic>? parameters});
  Future<BaseResponse> createAddress({Map<String, dynamic>? parameters});
  Future<BaseResponse> updateAddress({Map<String, dynamic>? parameters});
  Future<BaseResponse> deleteAddress({Map<String, dynamic>? parameters});
  Future<BaseResponse> setDefaultAddress({Map<String, dynamic>? parameters});
}
