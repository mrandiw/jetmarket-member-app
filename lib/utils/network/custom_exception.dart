import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jetmarket/utils/network/timeout_error.dart';
import 'data_state.dart';
import 'status_response.dart';

class CustomException<T> {
  DataState<T> dio(DioException e) {
    bool isTimeout = TimeOutError.check(e);
    if (isTimeout) {
      return DataState<T>(
        status: StatusResponse.timeout,
        message: "Request Timeout",
      );
    } else {
      String methode = "No Methode";
      String path = "Path - Notfound";
      String errorMessage = "Unknown error occurred";
      String divider =
          "=============================================================================================";

      if (e.response?.data is Map) {
        methode = e.response?.requestOptions.method ?? 'No Methode';
        errorMessage = e.response?.data['message'];
        path = e.response?.requestOptions.uri.toString() ?? '';
      } else {
        methode = e.response?.requestOptions.method ?? 'No Methode';

        // errorMessage = e.message.toString();
        errorMessage = "The error has not been handled on the server side yet.";

        path = e.response?.requestOptions.uri.toString() ?? '';
      }
      log("\n");
      log('\x1B[31m${"🚨 $methode ${e.response?.statusCode} | $path"}\x1B[0m');
      log('\x1B[31m${"🤯 Message : $errorMessage"}\x1B[0m');
      log('\x1B[31m${"🤯 Token : ${e.requestOptions.headers['Authorization']}"}\x1B[0m');

      log('\x1B[31m${"👹 $divider 👹"}\x1B[0m');
      log("\n");

      return DataState<T>(
        path: path,
        status: StatusResponse.failed,
        message: errorMessage,
      );
    }
  }
}
