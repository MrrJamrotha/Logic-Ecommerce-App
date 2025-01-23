import 'dart:convert';
// import 'dart:io';

import 'package:logic_app/core/common/base_response.dart';
import 'package:logic_app/core/error/error_handler.dart';
import 'package:logic_app/core/error/error_messages.dart';
import 'package:logic_app/core/error/exceptions.dart';
import 'package:logic_app/data/remote/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:logic_app/data/remote/network/api_endpoints.dart';
import 'package:logic_app/data/remote/network/api_interceptor.dart';

class ApiClient implements Api {
  final http.Client _client;
  ApiClient(this._client);

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
}
