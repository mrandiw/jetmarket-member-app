import 'package:get/get.dart';

import '../../../../presentation/checkout/controllers/checkout.controller.dart';

class CheckoutControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
  }
}
