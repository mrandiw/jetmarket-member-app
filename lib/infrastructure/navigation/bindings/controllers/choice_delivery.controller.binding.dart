import 'package:get/get.dart';

import '../../../../presentation/home_pages/choice_delivery/controllers/choice_delivery.controller.dart';

class ChoiceDeliveryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoiceDeliveryController>(
      () => ChoiceDeliveryController(),
    );
  }
}
