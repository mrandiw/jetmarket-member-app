import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/koperasi_pages/tagihan_payment_bill/controllers/tagihan_payment_bill.controller.dart';

class TagihanPaymentBillControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagihanPaymentBillController>(
      () => TagihanPaymentBillController(PaymentRepositoryImpl()),
    );
  }
}
