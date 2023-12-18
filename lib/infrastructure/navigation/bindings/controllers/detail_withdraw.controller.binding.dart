import 'package:get/get.dart';

import '../../../../presentation/wallet/detail_withdraw/controllers/detail_withdraw.controller.dart';

class DetailWithdrawControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWithdrawController>(
      () => DetailWithdrawController(),
    );
  }
}
