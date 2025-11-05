import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/notification.dart';

class DetailNotificationController extends GetxController {
  final args = Get.arguments;

  final _notification = NotificationData().obs;
  NotificationData get notification => _notification.value;
  set notification(NotificationData value) => _notification.value = value;

  @override
  void onInit() {
    notification = args['notification'];
    super.onInit();
  }
}
