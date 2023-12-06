import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/app_preference/app_preferences.dart';

class SplashScreenController extends GetxController {
  Future<void> start() async {
    await Future.delayed(3.seconds, () {
      Get.offAllNamed(Routes.MAIN_PAGES);
    });
  }
}
