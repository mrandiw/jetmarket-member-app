import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/saving_repository_impl.dart';

import '../../../../presentation/koperasi_pages/tabungan_payment/controllers/tabungan_payment.controller.dart';

class TabunganPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabunganPaymentController>(
      () => TabunganPaymentController(
          SavingRepositoryImpl(), PaymentRepositoryImpl()),
    );
  }
}
