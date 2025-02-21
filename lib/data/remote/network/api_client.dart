import 'dart:convert';
import 'dart:io';
// import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:logic_app/core/common/base_response.dart';
import 'package:logic_app/core/error/error_handler.dart';
import 'package:logic_app/core/error/error_messages.dart';
import 'package:logic_app/core/error/exceptions.dart';
import 'package:logic_app/core/helper/helper.dart';
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
  Future<BaseResponse> login({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.login),
        body: jsonEncode(parameters),
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
    }
  }

  @override
  Future<BaseResponse> register({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.register),
        body: jsonEncode(parameters),
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
    }
  }

  @override
  Future<BaseResponse> getUser({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getUserProfile),
        body: jsonEncode(parameters),
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException(ErrorMessages.serverError);
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
    }
  }

  @override
  Future<BaseResponse> updateUser({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.updateUserProfile),
        body: jsonEncode(parameters),
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
    }
  }

  @override
  Future<BaseResponse> getSlideShow({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getSlideShow),
        body: jsonEncode(parameters),
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
    }
  }

  @override
  Future<BaseResponse> getBrands({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getBrands),
        body: jsonEncode(parameters),
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);
      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['records'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'],
        message: body['message'],
        data: body['record'],
      );
    } catch (exception) {
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
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
        headers: ApiInterceptor.modifyHeaders(),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
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
      throw ErrorHandler.handleException(exception as Exception);
    }
  }
}
