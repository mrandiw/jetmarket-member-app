import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/home_pages/choice_payment/controllers/choice_payment.controller.dart';

class ChoicePaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoicePaymentController>(
      () => ChoicePaymentController(
          PaymentRepositoryImpl(), OrderRepositoryImpl()),
    );
  }
}
