import 'package:dio/dio.dart';
import 'custom_logger.dart';
import 'status_response.dart';

class StatusCodeResponse {
  static StatusResponse cek(
      {required Response<dynamic> response,
      bool? showLogs,
      bool? queryParams}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      CustomLogger.onResponseLogger(
          response: response, logRequest: showLogs, queryParams: queryParams);
      return StatusResponse.success;
    } else {
      return StatusResponse.failed;
    }
  }
}
