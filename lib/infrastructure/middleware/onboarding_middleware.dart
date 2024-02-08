import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_preference/app_preferences.dart';
import '../navigation/routes.dart';

class OnboardingMiddleware extends GetMiddleware {
  @override
  int? get priority => 3;

  @override
  RouteSettings? redirect(String? route) {
    final onboarding = AppPreference().cekSkipOnboarding();
    if (onboarding == null || onboarding == false) {
      return const RouteSettings(name: Routes.ONBOARDING);
    }
    return null;
  }
}
