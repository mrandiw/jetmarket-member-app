import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/koperasi_pages/choice_payment_tagihan/controllers/choice_payment_tagihan.controller.dart';
import '../../../dal/repository/loan_repository_impl.dart';

class ChoicePaymentTagihanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoicePaymentTagihanController>(
      () => ChoicePaymentTagihanController(
          LoanRepositoryImpl(), PaymentRepositoryImpl()),
    );
  }
}
