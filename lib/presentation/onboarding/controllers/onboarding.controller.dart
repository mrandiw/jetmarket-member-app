import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/app_preference/app_preferences.dart';
import '../../../utils/assets/assets_images.dart';

class OnboardingController extends GetxController {
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  String buttonSkip = "Skip";

  List onboardingData = [
    {
      'image': onboarding1,
      'title': 'Berjualan Dengan Mudah',
      'subtitle':
          'JetMarket adalah solusi yang tepat untuk Kamu yang ingin berjualan online dengan mudah.'
    },
    {
      'image': onboarding2,
      'title': 'Berjualan Dengan Murah',
      'subtitle':
          'JetMarket adalah solusi yang tepat untuk Kamu yang ingin berjualan online dengan mudah.'
    }
  ];

  void nextOnboarding(int index) {
    currentIndex = index;
    print(currentIndex);

    if (currentIndex == 1) {
    } else {
      carouselController.nextPage();
    }
    update();
  }

  void skipOnboarding() {
    if (currentIndex == 1) {
      getStarted();
    } else {
      currentIndex = 1;
      update();
      carouselController.animateToPage(1);
    }
  }

  void getStarted() {
    AppPreference().skipOnboarding(true);
    Get.offNamed(Routes.LOGIN);
  }
}
