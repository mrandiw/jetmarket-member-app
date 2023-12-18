import 'package:get/get.dart';

import '../../../../presentation/wallet/withdraw/controllers/withdraw.controller.dart';

class WithdrawControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawController>(
      () => WithdrawController(),
    );
  }
}
