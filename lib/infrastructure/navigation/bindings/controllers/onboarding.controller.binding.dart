import 'package:get/get.dart';

import '../../../../presentation/onboarding/controllers/onboarding.controller.dart';

class OnboardingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
  }
}
