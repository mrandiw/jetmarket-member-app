import 'package:get/get.dart';

import '../../../../presentation/home_pages/checkout/controllers/checkout.controller.dart';

class CheckoutControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
  }
}
