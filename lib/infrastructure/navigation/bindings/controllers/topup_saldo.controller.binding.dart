import 'package:get/get.dart';

import '../../../../presentation/wallet/topup_saldo/controllers/topup_saldo.controller.dart';

class TopupSaldoControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopupSaldoController>(
      () => TopupSaldoController(),
    );
  }
}
