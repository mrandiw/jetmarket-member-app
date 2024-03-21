import 'package:get/get.dart';

import 'network_controller.dart';

class NetWorkInjection {
  static void init() {
    Get.put(NetWorkController(), permanent: true);
  }
}
