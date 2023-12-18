import 'dart:developer';

import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/notification_repository.dart';
import 'package:jetmarket/utils/network/status_response.dart';

class FirebaseController extends GetxController {
  final NotificationRepository _notificationRepository;
  FirebaseController(this._notificationRepository);

  int unreadCount = 0;

  Future<void> getUnreadNotification() async {
    final response = await _notificationRepository.getUnreadCount();
    log(response.message ?? 'jk');
    if (response.status == StatusResponse.success) {
      unreadCount = response.result ?? 0;
      update();
    }
  }
}
