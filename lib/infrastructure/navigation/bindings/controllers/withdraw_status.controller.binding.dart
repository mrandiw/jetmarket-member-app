import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/ewallet_repository_impl.dart';

import '../../../../presentation/wallet/withdraw_status/controllers/withdraw_status.controller.dart';

class WithdrawStatusControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawStatusController>(
      () => WithdrawStatusController(EwalletRepositoryImpl()),
    );
  }
}
