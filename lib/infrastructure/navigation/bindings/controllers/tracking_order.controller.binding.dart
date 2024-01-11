import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/order_pages/tracking_order/controllers/tracking_order.controller.dart';

class TrackingOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingOrderController>(
      () => TrackingOrderController(OrderRepositoryImpl()),
    );
  }
}
