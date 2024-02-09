import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/chat_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';

import '../../../../presentation/notification/controllers/notification.controller.dart';

class NotificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(
          NotificationRepositoryImpl(), ChatRepositoryImpl()),
    );
  }
}
