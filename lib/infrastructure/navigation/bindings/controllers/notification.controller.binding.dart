import 'package:get/get.dart';

import '../../../../presentation/notification/controllers/notification.controller.dart';

class NotificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
