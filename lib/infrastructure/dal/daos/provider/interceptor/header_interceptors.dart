import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_preference/app_preferences.dart';

InterceptorsWrapper headerInterceptor({required bool logs}) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.connectTimeout = 8.seconds;
      options.receiveTimeout = 8.seconds;
      options.sendTimeout = 8.seconds;

      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      String? accessToken;
      if (options.path == "payment/method" ||
          options.path == "payment/customer_register") {
        accessToken = AppPreference().getRegisterToken();
      } else if (options.path == "auth/otp-forgot/send") {
        accessToken = null;
      } else {
        accessToken = AppPreference().getAccessToken();
      }
      if (accessToken != null) {
        options.headers[HttpHeaders.authorizationHeader] =
            'Bearer $accessToken';
      }

      return handler.next(options);
    },
    onResponse: (response, handler) {
      return handler.next(response);
    },
    onError: (err, handler) {
      if (err.response?.statusCode == 401) {
        AppPreference().clearAccessToken();
        // Get.offAllNamed(Routes.LOGIN);
      }
      return handler.reject(err);
    },
  );
}
