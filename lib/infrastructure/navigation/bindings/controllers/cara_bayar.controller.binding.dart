import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';

import '../../../../presentation/order_pages/cara_bayar/controllers/cara_bayar.controller.dart';

class CaraBayarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaraBayarController>(
      () => CaraBayarController(PaymentRepositoryImpl(), OrderRepositoryImpl()),
    );
  }
}
