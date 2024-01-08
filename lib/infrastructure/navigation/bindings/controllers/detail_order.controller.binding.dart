import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/order_pages/detail_order/controllers/detail_order.controller.dart';

class DetailOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderController>(
      () => DetailOrderController(OrderRepositoryImpl()),
    );
  }
}
