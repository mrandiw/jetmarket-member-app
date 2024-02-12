import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/global/constant.dart';
import '../navigation/routes.dart';

class DeeplinkMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (deeplinkArgument != null) {
      if (deeplinkArgument['route'] == 'register') {
        return RouteSettings(
            name: Routes.REGISTER, arguments: deeplinkArgument['referral']);
      } else {
        return RouteSettings(
            name: Routes.DETAIL_PRODUCT,
            arguments: [deeplinkArgument['id'], 'from-deeplink']);
      }
    } else {
      return null;
    }
  }
}
