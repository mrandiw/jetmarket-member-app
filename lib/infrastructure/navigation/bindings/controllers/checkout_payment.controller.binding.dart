import 'package:get/get.dart';

import '../../../../presentation/checkout_payment/controllers/checkout_payment.controller.dart';

class CheckoutPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutPaymentController>(
      () => CheckoutPaymentController(),
    );
  }
}
