import 'package:get/get.dart';

import '../../../../presentation/home_pages/choice_payment/controllers/choice_payment.controller.dart';

class ChoicePaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoicePaymentController>(
      () => ChoicePaymentController(),
    );
  }
}
