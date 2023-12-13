import 'package:get/get.dart';

import '../../../../presentation/order_pages/tracking_return/controllers/tracking_return.controller.dart';

class TrackingReturnControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingReturnController>(
      () => TrackingReturnController(),
    );
  }
}
