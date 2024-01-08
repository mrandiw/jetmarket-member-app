import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/home_pages/payment_payletter/controllers/payment_payletter.controller.dart';

class PaymentPayletterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentPayletterController>(
      () => PaymentPayletterController(
          PaymentRepositoryImpl(), OrderRepositoryImpl()),
    );
  }
}
