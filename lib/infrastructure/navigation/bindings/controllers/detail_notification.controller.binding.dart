import 'package:get/get.dart';

import '../../../../presentation/detail_notification/controllers/detail_notification.controller.dart';

class DetailNotificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNotificationController>(
      () => DetailNotificationController(),
    );
  }
}
