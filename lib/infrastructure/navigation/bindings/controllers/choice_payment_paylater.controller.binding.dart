import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/paylater_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/account_pages/choice_payment_paylater/controllers/choice_payment_paylater.controller.dart';

class ChoicePaymentPaylaterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoicePaymentPaylaterController>(
      () => ChoicePaymentPaylaterController(
          PaymentRepositoryImpl(), PaylaterRepositoryImpl()),
    );
  }
}
