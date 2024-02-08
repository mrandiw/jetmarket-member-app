import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/global/constant.dart';
import '../navigation/routes.dart';

class UniLinkMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // ignore: unnecessary_null_comparison
    if (deeplinkArgument != null) {
      return RouteSettings(name: Routes.REGISTER, arguments: deeplinkArgument);
    } else {
      return null;
    }
  }
}
