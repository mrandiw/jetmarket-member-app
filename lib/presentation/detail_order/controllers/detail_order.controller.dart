import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';

class DetailOrderController extends GetxController {
  String statusOrder = "";
  bool onDelivery = false;

  void toComplain() {
    Get.toNamed(Routes.KOMPLAIN);
  }

  void confirmOrder() {}

  @override
  void onInit() {
    statusOrder = Get.arguments['status'];
    super.onInit();
  }
}
