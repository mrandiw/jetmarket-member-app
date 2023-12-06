import 'package:get/get.dart';
import 'package:jetmarket/presentation/order/controllers/order.controller.dart';

import '../../../../presentation/main_pages/controllers/main_pages.controller.dart';

class MainPagesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPagesController>(
      () => MainPagesController(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
  }
}
