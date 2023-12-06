import 'package:get/get.dart';

import '../../../../presentation/cara_bayar/controllers/cara_bayar.controller.dart';

class CaraBayarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaraBayarController>(
      () => CaraBayarController(),
    );
  }
}
