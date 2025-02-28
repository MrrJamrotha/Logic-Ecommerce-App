import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logic_app/core/common/base_response.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/data/remote/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:logic_app/data/remote/network/api_endpoints.dart';
import 'package:logic_app/data/remote/network/api_interceptor.dart';

class ApiClient implements Api {
  final http.Client _client;
  ApiClient(this._client);

  final _session = di.get<UserSessionService>();

  Future<Map<String, dynamic>> getParams() async {
    try {
      var auth = await _session.getUser();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      String appId =
          Platform.isAndroid ? allInfo['id'] : allInfo['identifierForVendor'];
      String locale = "en";
      String currencyCode = "USD";
      if (auth != null) {
        locale = auth.locale;
        currencyCode = auth.currencyCode;
      }
      return {
        'code': currencyCode,
        'locale': locale,
        'application_id': appId,
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BaseResponse> getUserProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getUserProfile),
        body: jsonEncode(mergedParams),
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
  Future<BaseResponse> getSlideShow({Map<String, dynamic>? parameters}) async {
    try {
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getSlideShow),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getBrands),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getBrowseCategories),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getRecommendedForYou),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getNewArrivals),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductBastReview),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getSpacialProduct),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getRelatedProduct),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getMerchntProfile),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductByMerchnt),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductByBrand),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getProductByCategory),
        body: jsonEncode(mergedParams),
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
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getItemDetail),
        body: jsonEncode(mergedParams),
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

      if (body['token'] != null) {
        await _session.storeToken(body['token']);
      }

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

  @override
  Future<BaseResponse> getUserAddress({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getUserAddress),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

      return BaseResponse(
        statusCode: response.statusCode,
        status: body['status'] ?? "",
        message: body['message'] ?? "",
        data: body['records'] ?? "",
        lastPage: AppFormat.toInt(body['last_page'] ?? 1),
        currentPage: AppFormat.toInt(body['current_page'] ?? 1),
      );
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<BaseResponse> createAddress({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.createAddress),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);
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

  @override
  Future<BaseResponse> deleteAddress({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.deleteAddress),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> getAddressById({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getAddressById),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> updateAddress({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.updateAddress),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> setDefaultAddress({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.setDefaultAddress),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> loginWithGoogle({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.loginWithGoogle),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

      if (body['token'] != null) {
        await _session.storeToken(body['token']);
      }

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

  @override
  Future<BaseResponse> updateUserProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      // final response = await _client.post(
      //   Uri.parse(ApiEndpoints.updateUserProfile),
      //   body: jsonEncode(parameters),
      //   headers: await ApiInterceptor.modifyHeaders(),
      // );
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiEndpoints.updateUserProfile),
      );
      // Add headers
      final headers = await ApiInterceptor.modifyHeaders();
      request.headers.addAll(headers);

      // Add text fields
      if (parameters != null) {
        parameters.forEach((key, value) {
          if (value is String) {
            request.fields[key] = value;
          }
        });
      }

      // Attach file if available
      if (parameters?['file'] != null) {
        final file = parameters!['file'] as XFile;
        request.files.add(await http.MultipartFile.fromPath(
          'file', // API key for the file field (adjust if needed)
          file.path,
          filename: file.name,
        ));
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> changeCurrencyCode({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.changeCurrencyCode),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> changeLocale({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.changeLocale),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> addToWishlist({Map<String, dynamic>? parameters}) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.addToWishlist),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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

  @override
  Future<BaseResponse> getMyWishlist({Map<String, dynamic>? parameters}) async {
    try {
      var params = await getParams();
      final mergedParams = {...?parameters, ...params};
      final response = await _client.post(
        Uri.parse(ApiEndpoints.getMyWishlist),
        body: jsonEncode(mergedParams),
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
  Future<BaseResponse> removeFromWishlist({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.removeFromWishlist),
        body: jsonEncode(parameters),
        headers: await ApiInterceptor.modifyHeaders(),
      );
      final body = jsonDecode(response.body);

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
