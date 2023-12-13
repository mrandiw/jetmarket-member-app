import 'package:get/get.dart';

import '../../../../presentation/order_pages/payment_success_retail/controllers/payment_success_retail.controller.dart';

class PaymentSuccessRetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessRetailController>(
      () => PaymentSuccessRetailController(),
    );
  }
}
