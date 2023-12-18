import 'package:get/get.dart';

import '../../../../presentation/wallet/withdraw_status/controllers/withdraw_status.controller.dart';

class WithdrawStatusControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawStatusController>(
      () => WithdrawStatusController(),
    );
  }
}
