import 'package:get/get.dart';

import '../../../../presentation/order_pages/cara_bayar/controllers/cara_bayar.controller.dart';

class CaraBayarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaraBayarController>(
      () => CaraBayarController(),
    );
  }
}
