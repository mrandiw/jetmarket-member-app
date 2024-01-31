import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/ewallet_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/wallet/choice_payment_topup/controllers/choice_payment_topup.controller.dart';

class ChoicePaymentTopupControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoicePaymentTopupController>(
      () => ChoicePaymentTopupController(
          PaymentRepositoryImpl(), EwalletRepositoryImpl()),
    );
  }
}
