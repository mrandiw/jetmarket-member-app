import 'package:get/get.dart';

import '../../../../presentation/order_pages/komplain/controllers/komplain.controller.dart';

class KomplainControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomplainController>(
      () => KomplainController(),
    );
  }
}
