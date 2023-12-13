import 'package:get/get.dart';

import '../../../../presentation/order_pages/tracking_return_order/controllers/tracking_return_order.controller.dart';

class TrackingReturnOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingReturnOrderController>(
      () => TrackingReturnOrderController(),
    );
  }
}
