import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:logic_app/core/common/base_response.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/data/remote/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:logic_app/data/remote/network/api_endpoints.dart';
import 'package:logic_app/data/remote/network/api_interceptor.dart';

class ApiClient implements Api {
  final http.Client _client;
  ApiClient(this._client);

  Future<String> getAppId() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      return Platform.isAndroid
          ? allInfo['id']
          : allInfo['identifierForVendor'];
    } catch (e) {
      logger.e(e);
      return '';
    }
  }

  @override
  Future<BaseResponse> getUser({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getUserProfile),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> updateUser({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.updateUserProfile),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getSlideShow({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getSlideShow),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getBrands({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getBrands),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getBrowseCategories({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getBrowseCategories),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getRecommendForYou({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getRecommendedForYou),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
        categories: body['categories'] ?? [],
        brands: body['brands'] ?? [],
        priceRange: body['price_range'] ?? {},
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getProductNewArrivals({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getNewArrivals),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
        categories: body['categories'] ?? [],
        brands: body['brands'] ?? [],
        priceRange: body['price_range'] ?? {},
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getProductBastReview({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductBastReview),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'] ?? "",
        categories: body['categories'] ?? [],
        brands: body['brands'] ?? [],
        priceRange: body['price_range'] ?? {},
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getSpacialProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getSpacialProduct),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
        categories: body['categories'] ?? [],
        brands: body['brands'] ?? [],
        priceRange: body['price_range'] ?? {},
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getRelatedProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getRelatedProduct),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getMerchantProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getMerchntProfile),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['record'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getProductByMerchnat({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductByMerchnt),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getProductByBrand({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductByBrand),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
        categories: body['categories'] ?? [],
        priceRange: body['price_range'] ?? {},
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getProductByCategory({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductByCategory),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'] ?? [],
        brands: body['brands'] ?? [],
        priceRange: body['price_range'] ?? {},
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> getItemDetail({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getItemDetail),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['record'] ?? [],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> generateOtpCode({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.generateOtpCode),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );

      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['status'],
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> verifyOTP({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.verifyOTP),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);
      final session = di.get<UserSessionService>();
      await session.storeToken(body['token']);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'] ?? "",
        message: body['message'] ?? "",
        data: body['record'] ?? "",
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
