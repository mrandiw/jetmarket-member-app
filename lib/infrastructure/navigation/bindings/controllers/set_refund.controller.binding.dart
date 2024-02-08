import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/delivery_repository_impl.dart';

import '../../../../presentation/order_pages/set_refund/controllers/set_refund.controller.dart';

class SetRefundControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetRefundController>(
      () => SetRefundController(DeliveryRepositoryImpl()),
    );
  }
}
