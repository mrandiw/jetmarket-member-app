import 'package:dio/dio.dart';

class TimeOutError {
  static bool check(DioException dio) {
    if (dio.type == DioExceptionType.connectionTimeout ||
        dio.type == DioExceptionType.receiveTimeout) {
      return true;
    } else {
      return false;
    }
  }
}
