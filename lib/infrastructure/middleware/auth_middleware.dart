import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/argument/payment_methode_argument.dart';

import '../../utils/app_preference/app_preferences.dart';
import '../navigation/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    bool isTokenReady = AppPreference().getAccessToken() != null;
    bool isRegistered = AppPreference().cekRegistered() != null;
    bool isVerified = AppPreference().cekVerify() != null;
    bool isPaid = AppPreference().getTrxId() != null;

    if (isRegistered && !isVerified && isTokenReady) {
      return const RouteSettings(name: Routes.REGISTER_OTP);
    } else if (isRegistered && isVerified && !isPaid) {
      return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
    } else if (isRegistered && isVerified && isPaid) {
      var argument = PaymentMethodeArgument(
          trxId: AppPreference().getTrxId(), status: "waiting");
      return RouteSettings(
          name: Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
    } else if (!isTokenReady) {
      return const RouteSettings(name: Routes.LOGIN);
    } else {
      return null;
    }
  }
}
