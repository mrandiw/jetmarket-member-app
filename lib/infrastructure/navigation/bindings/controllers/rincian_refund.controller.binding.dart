import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/order_pages/rincian_refund/controllers/rincian_refund.controller.dart';

class RincianRefundControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RincianRefundController>(
      () => RincianRefundController(OrderRepositoryImpl()),
    );
  }
}
