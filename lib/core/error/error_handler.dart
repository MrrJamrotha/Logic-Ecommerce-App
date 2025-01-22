import 'exceptions.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handleException(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else {
      return const GenericFailure('An unknown error occurred');
    }
  }
}
