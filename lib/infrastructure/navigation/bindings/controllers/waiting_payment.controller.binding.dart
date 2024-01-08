import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/order_pages/waiting_payment/controllers/waiting_payment.controller.dart';

class WaitingPaymentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingPaymentController>(
      () => WaitingPaymentController(OrderRepositoryImpl()),
    );
  }
}
