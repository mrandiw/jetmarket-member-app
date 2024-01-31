import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/ewallet_repository_impl.dart';

import '../../../../presentation/wallet/withdraw/controllers/withdraw.controller.dart';

class WithdrawControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawController>(
      () => WithdrawController(EwalletRepositoryImpl()),
    );
  }
}
