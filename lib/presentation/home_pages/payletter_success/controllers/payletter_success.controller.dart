import 'package:get/get.dart';

import '../../../../infrastructure/dal/repository/order_repository_impl.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';
import '../../../order_pages/order/controllers/order.controller.dart';

class PayletterSuccessController extends GetxController {
  void backtoMerchent() {
    Get.offAllNamed(Routes.MAIN_PAGES);
    final controller = Get.put(MainPagesController());
    final controller2 = Get.put(OrderController(OrderRepositoryImpl()));
    controller.changeTabIndex(1);
    controller2.getWaitingOrderLenght();
  }

  void toDetail() {
    Get.offNamedUntil(Routes.DETAIL_ORDER,
        (routes) => routes.settings.name == Routes.MAIN_PAGES,
        arguments: [Get.arguments, null]);
    final controller = Get.put(MainPagesController());
    final controller2 = Get.put(OrderController(OrderRepositoryImpl()));
    controller.changeTabIndex(1);
    controller2.getWaitingOrderLenght();
  }
}
