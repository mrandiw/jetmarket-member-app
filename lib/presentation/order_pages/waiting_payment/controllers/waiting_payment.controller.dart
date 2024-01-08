import 'dart:developer';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/waiting_payment.dart';
import '../../../../utils/network/status_response.dart';

class WaitingPaymentController extends GetxController {
  final OrderRepository _orderRepository;
  WaitingPaymentController(this._orderRepository);

  List<WaitingPaymentModel> waitingPayment = [];

  Future<void> getWaitingPayment() async {
    final response = await _orderRepository.getListWaitingPayment();
    if (response.status == StatusResponse.success) {
      waitingPayment.assignAll(response.result ?? []);
      update();
    }
  }

  String assetImage(String path) {
    return "assets/images/${path.toLowerCase()}.png";
  }

  void toCaraBayar(int id) {
    Get.toNamed(Routes.CARA_BAYAR, arguments: id);
  }

  void toListOrder(int id) {
    Get.toNamed(Routes.ORDER_LIST_TRANSACTION, arguments: id);
  }

  @override
  void onInit() {
    getWaitingPayment();
    super.onInit();
  }
}
