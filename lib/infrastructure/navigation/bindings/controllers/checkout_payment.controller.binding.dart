import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/home_pages/checkout_payment/controllers/checkout_payment.controller.dart';

class CheckoutPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutPaymentController>(
      () => CheckoutPaymentController(PaymentRepositoryImpl()),
    );
  }
}
