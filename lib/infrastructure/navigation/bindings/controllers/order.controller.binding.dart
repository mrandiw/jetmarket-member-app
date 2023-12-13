import 'package:get/get.dart';

import '../../../../presentation/order_pages/order/controllers/order.controller.dart';

class OrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
  }
}
