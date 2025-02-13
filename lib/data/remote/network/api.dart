import 'package:logic_app/core/common/base_response.dart';

abstract class Api {
  Future<BaseResponse> login({Map<String, dynamic>? parameters});
  Future<BaseResponse> register({Map<String, dynamic>? parameters});

  Future<BaseResponse> getUser({Map<String, dynamic>? parameters});
  Future<BaseResponse> updateUser({Map<String, dynamic>? parameters});

  Future<BaseResponse> getSlideShow({Map<String, dynamic>? parameters});
  Future<BaseResponse> getBrowseCategories({Map<String, dynamic>? parameters});
  Future<BaseResponse> getBrands({Map<String, dynamic>? parameters});
  Future<BaseResponse> getRecommendForYou({Map<String, dynamic>? parameters});
}
