import 'package:get/get.dart';

import '../../../../presentation/wallet/payment_topup_saldo/controllers/payment_topup_saldo.controller.dart';

class PaymentTopupSaldoControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentTopupSaldoController>(
      () => PaymentTopupSaldoController(),
    );
  }
}
