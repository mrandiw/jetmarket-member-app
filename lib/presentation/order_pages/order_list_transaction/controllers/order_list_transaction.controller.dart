import 'dart:developer';

import 'package:get/get.dart';
import 'package:jetmarket/utils/network/status_response.dart';

import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/product_order_customer.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';

class OrderListTransactionController extends GetxController {
  final OrderRepository _orderRepository;
  OrderListTransactionController(this._orderRepository);
  List<ProductOrderCustomer> products = [];

  Future<void> getListOrder(String id) async {
    log(id);
    final response = await _orderRepository.getListOrderCustomer(id);
    if (response.status == StatusResponse.success) {
      products = response.result ?? [];
      update();
    }
  }

  void toDetailOrder(int id) {
    Get.toNamed(Routes.DETAIL_ORDER, arguments: [id, null, null, null]);
  }

  void bacAction() {
    if (Get.arguments[1] != null) {
      Get.offNamed(Routes.MAIN_PAGES);
      Get.put(MainPagesController());
    } else {
      Get.back();
    }
  }

  @override
  void onInit() {
    getListOrder(Get.arguments[0]);
    super.onInit();
  }
}
