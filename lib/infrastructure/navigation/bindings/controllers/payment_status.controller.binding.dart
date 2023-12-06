import 'package:get/get.dart';

import '../../../../presentation/auth/payment_status/controllers/payment_status.controller.dart';

class PaymentStatusControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentStatusController>(
      () => PaymentStatusController(),
    );
  }
}
