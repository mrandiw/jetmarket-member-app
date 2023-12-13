import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/payment_tabungan_success/controllers/payment_tabungan_success.controller.dart';

class PaymentTabunganSuccessControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentTabunganSuccessController>(
      () => PaymentTabunganSuccessController(),
    );
  }
}
