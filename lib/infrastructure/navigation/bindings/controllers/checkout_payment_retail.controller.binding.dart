import 'package:get/get.dart';

import '../../../../presentation/checkout_payment_retail/controllers/checkout_payment_retail.controller.dart';

class CheckoutPaymentRetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutPaymentRetailController>(
      () => CheckoutPaymentRetailController(),
    );
  }
}
