import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/argument/payment_methode_argument.dart';
import 'package:jetmarket/domain/core/model/model_data/user_model.dart';

import '../../../utils/app_preference/app_preferences.dart';
import '../navigation/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    bool isTokenReady = AppPreference().getAccessToken() != null;
    bool isRegistered = AppPreference().cekRegistered() != null;
    bool isVerified = AppPreference().cekVerify() != null;
    bool isCreatePayment = AppPreference().getTrxId() != null;
    int? timePayment = AppPreference().getCountDown();
    UserModel? userData = AppPreference().getUserData();
    print("Token : ${AppPreference().getAccessToken()}");
    print("Time : $timePayment");
    print("Registered : $isRegistered");
    print("Verified : $isVerified");
    print("Create Payment : $isCreatePayment");
    print("Veri : ${userData?.user?.isVerified}");
    print(userData?.trxId);

    if (isRegistered && !isVerified) {
      return const RouteSettings(name: Routes.REGISTER_OTP);
    } else if (isRegistered && isVerified && !isCreatePayment) {
      return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
    } else if (isRegistered && isVerified && isCreatePayment) {
      var argument = PaymentMethodeArgument(
          trxId: AppPreference().getTrxId(), status: "waiting");
      return RouteSettings(
          name: Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
    } else if (!isTokenReady) {
      return const RouteSettings(name: Routes.LOGIN);
    } else if (timePayment != null) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      int elapsed = currentTime - timePayment;
      int remainingTime = (24 * 60 * 60 * 1000) - elapsed;
      if (remainingTime <= 0) {
        return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
      } else {
        var argument = PaymentMethodeArgument(
            trxId: AppPreference().getTrxId(), status: "waiting");
        return RouteSettings(
            name: Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
      }
    } else if (isTokenReady) {
      if (userData?.user?.activatedAt != '0001-01-01T00:00:00Z') {
        return null;
      } else {
        if (userData?.user?.isVerified == true) {
          if (userData?.trxId != null) {
            var argument = PaymentMethodeArgument(
                trxId: AppPreference().getTrxId(), status: "waiting");
            return RouteSettings(
                name: Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
          } else {
            return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
          }
        } else {
          return const RouteSettings(name: Routes.REGISTER_OTP);
        }
      }
    }
    return null;

    // if (isRegistered && !isVerified) {
    //   return const RouteSettings(name: Routes.REGISTER_OTP);
    // } else if (isRegistered && isVerified && !isCreatePayment) {
    //   return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
    // } else if (isRegistered && isVerified && isCreatePayment) {
    //   var argument = PaymentMethodeArgument(
    //       trxId: AppPreference().getTrxId(), status: "waiting");
    //   return RouteSettings(
    //       name: Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
    // } else if (!isTokenReady) {
    //   return const RouteSettings(name: Routes.LOGIN);
    // } else {
    //   return null;
    // }

    // return null;
  }
}
