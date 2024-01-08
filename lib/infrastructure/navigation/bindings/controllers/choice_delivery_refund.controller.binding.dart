import 'package:get/get.dart';

import '../../../../presentation/order_pages/choice_delivery_refund/controllers/choice_delivery_refund.controller.dart';

class ChoiceDeliveryRefundControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoiceDeliveryRefundController>(
      () => ChoiceDeliveryRefundController(),
    );
  }
}
