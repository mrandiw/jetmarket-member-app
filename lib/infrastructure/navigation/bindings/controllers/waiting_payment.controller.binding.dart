import 'package:get/get.dart';

import '../../../../presentation/waiting_payment/controllers/waiting_payment.controller.dart';

class WaitingPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingPaymentController>(
      () => WaitingPaymentController(),
    );
  }
}
