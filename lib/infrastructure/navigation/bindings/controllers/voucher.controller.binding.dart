import 'package:get/get.dart';

import '../../../../presentation/home_pages/voucher/controllers/voucher.controller.dart';

class VoucherControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherController>(
      () => VoucherController(),
    );
  }
}
