import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handler(String statusCode) {
    failure = _handleError(statusCode);
  }

  Failure _handleError(String statusCode) {
    switch (statusCode) {
      case '400':
        return DataSourceType.badRequest.getFailure();
      case '401':
        return DataSourceType.unauthorized.getFailure();
      case '403':
        return DataSourceType.forbidden.getFailure();
      case '404':
        return DataSourceType.notFound.getFailure();
      case '405':
        return DataSourceType.methodNotAllowed.getFailure();
      case '408':
        return DataSourceType.requestTimeout.getFailure();
      case '429':
        return DataSourceType.tooManyRequests.getFailure();
      case '500':
        return DataSourceType.internalServerError.getFailure();
      case '501':
        return DataSourceType.notImplemented.getFailure();
      case '502':
        return DataSourceType.badGateway.getFailure();
      case '503':
        return DataSourceType.serviceUnavailable.getFailure();
      case '504':
        return DataSourceType.gatewayTimeout.getFailure();
      default:
        return DataSourceType.internalServerError.getFailure();
    }
  }
}
