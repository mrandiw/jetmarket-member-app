import 'package:get/get.dart';

import '../../../../presentation/order/controllers/order.controller.dart';

class OrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
  }
}
