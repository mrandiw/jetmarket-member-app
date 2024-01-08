import 'package:get/get.dart';

import '../../../../presentation/home_pages/detail_payment_customer/controllers/detail_payment_customer.controller.dart';
import '../../../dal/repository/payment_repository_impl.dart';

class DetailPaymentCustomerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPaymentCustomerController>(
      () => DetailPaymentCustomerController(PaymentRepositoryImpl()),
    );
  }
}
