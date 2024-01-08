import 'package:get/get.dart';

import '../../../../presentation/home_pages/payletter_success/controllers/payletter_success.controller.dart';

class PayletterSuccessControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayletterSuccessController>(
      () => PayletterSuccessController(),
    );
  }
}
