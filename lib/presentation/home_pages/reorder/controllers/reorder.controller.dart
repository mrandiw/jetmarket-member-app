import 'dart:developer';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/reorder_id.dart';

class ReorderController extends GetxController {
  final OrderRepository _orderRepository;
  ReorderController(this._orderRepository);

  List<ReOrderId> cartIdReorders = [];

  Future<void> reOrder() async {
    log("Haloooo");
    log("Ada lhoo ${Get.arguments[0]}");
    final response = await _orderRepository.getReorderId(Get.arguments[0]);
    if (response.result != null) {
      cartIdReorders = response.result ?? [];
      Get.offNamed(Routes.CART, arguments: cartIdReorders);
      log(cartIdReorders.length.toString());
    }
  }

  @override
  void onInit() {
    reOrder();
    super.onInit();
  }
}
