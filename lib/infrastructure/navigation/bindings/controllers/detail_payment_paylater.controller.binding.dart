import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/account_pages/detail_payment_paylater/controllers/detail_payment_paylater.controller.dart';

class DetailPaymentPaylaterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPaymentPaylaterController>(
      () => DetailPaymentPaylaterController(PaymentRepositoryImpl()),
    );
  }
}
