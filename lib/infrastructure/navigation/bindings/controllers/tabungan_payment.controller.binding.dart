import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/tabungan_payment/controllers/tabungan_payment.controller.dart';

class TabunganPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabunganPaymentController>(
      () => TabunganPaymentController(),
    );
  }
}
