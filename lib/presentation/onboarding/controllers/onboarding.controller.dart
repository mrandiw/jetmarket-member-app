import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../utils/app_preference/app_preferences.dart';
import '../../../../utils/assets/assets_images.dart';

class OnboardingController extends GetxController {
  int currentIndex = 0;

  String buttonSkip = "Skip";
  PageController pageController = PageController();

  List onboardingData = [
    {
      'image': onboarding1,
      'title': 'Belanja lebih praktis',
      'subtitle':
          'Dengan jetmarket anda tidak perlu keluar rumah untuk berbelanja.'
    },
    {
      'image': onboarding2,
      'title': 'Belanja lebih hemat',
      'subtitle':
          'Barang yang dijual di aplikasi jetmarket cenderung lebih murah'
    }
  ];

  void nextPage() {
    if (pageController.page == 0) {
      pageController.animateToPage(1,
          duration: 300.milliseconds, curve: Curves.easeIn);
    } else {
      getStarted();
    }
  }

  void skipOnboarding() {
    if (currentIndex == 1) {
      getStarted();
    } else {
      currentIndex++;
      update();
    }
  }

  void getStarted() {
    AppPreference().skipOnboarding(true);
    Get.offNamed(Routes.LOGIN);
  }
}
