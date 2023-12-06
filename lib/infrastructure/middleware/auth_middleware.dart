import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/user_model.dart';

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
    UserModel? userData = AppPreference().getUserData();
    bool isPaid = userData?.trxId != null;
    final onboarding = AppPreference().cekSkipOnboarding();
    var token = AppPreference().getRegisterToken();
    print("Token : $isTokenReady");
    print("Registered : $isRegistered");
    print("Verify : $isVerified");
    print("Paid : $isPaid");
    print("Onboarding : $onboarding");
    print("User : ${userData?.trxId}");
    print("Token : $token");

    if (isRegistered && !isVerified && isTokenReady) {
      return const RouteSettings(name: Routes.REGISTER_OTP);
    } else if (isRegistered && isVerified && !isPaid && isTokenReady) {
      return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
    } else if (!isTokenReady) {
      return const RouteSettings(name: Routes.LOGIN);
    } else {
      return null;
    }

    // if (isRegistered && !isVerified && !isTokenReady) {
    //   return const RouteSettings(name: Routes.REGISTER_OTP);
    // } else if (isRegistered && isVerified && !isPaid && !isTokenReady) {
    //   return const RouteSettings(name: Routes.SUCCESS_VERIFY_OTP);
    // } else if (!isTokenReady) {
    //   return const RouteSettings(name: Routes.LOGIN);
    // } else {
    //   return null;
    // }
  }
}
