import 'package:get/get.dart';

import '../../../../presentation/tracking_return/controllers/tracking_return.controller.dart';

class TrackingReturnControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingReturnController>(
      () => TrackingReturnController(),
    );
  }
}
