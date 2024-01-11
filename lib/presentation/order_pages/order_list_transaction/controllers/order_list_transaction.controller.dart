import 'dart:developer';

import 'package:get/get.dart';
import 'package:jetmarket/utils/network/status_response.dart';

import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/product_order_customer.dart';
import '../../../../infrastructure/navigation/routes.dart';

class OrderListTransactionController extends GetxController {
  final OrderRepository _orderRepository;
  OrderListTransactionController(this._orderRepository);
  List<ProductOrderCustomer> products = [];

  Future<void> getListOrder(int id) async {
    log("Jalan");
    final response = await _orderRepository.getListOrderCustomer(id);
    if (response.status == StatusResponse.success) {
      products = response.result ?? [];
      update();
    }
  }

  void toDetailOrder(int id) {
    Get.toNamed(Routes.DETAIL_ORDER, arguments: [id, null]);
  }

  @override
  void onInit() {
    print("JJL");
    getListOrder(Get.arguments);
    super.onInit();
  }
}
