import 'package:get/get.dart';

import '../../../../presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';

class EWalletControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EWalletController>(
      () => EWalletController(),
    );
  }
}
