import 'dart:developer';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';

import '../../../../domain/core/model/model_data/detail_order_customer.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../order/controllers/order.controller.dart';

class DetailOrderController extends GetxController {
  final OrderRepository _orderRepository;

  DetailOrderController(this._orderRepository);

  DetailOrderCustomer? detailOrderCustomer;

  var screenStatus = (ScreenStatus.initalize).obs;
  String statusOrder = "";
  int totalPrice = 0;
  bool onDelivery = false;

  Future<void> getDetailOrder() async {
    screenStatus(ScreenStatus.loading);
    final response = await _orderRepository.getDetailOrder(Get.arguments[0]);
    if (response.status == StatusResponse.success) {
      detailOrderCustomer = response.result;
      statusOrder = detailOrderCustomer?.status ?? '';
      log(detailOrderCustomer?.toJson().toString() ?? '');
      countTotalPrice();
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  int typeStatus(String status) {
    switch (status) {
      case "ON_DELIVERY":
      case "WAITING_CUSTOMER_CONFIRMATION":
        return 1;
      case 'FINISHED':
        return 2;
      case "PENDING":
      case "WAITING_DELIVERY":
      case "WAITING_PAYMENT":
      case "WAITING_SELLER_CONFIRMATION":
        return 3;
      case "REQUEST_REFUND_CUSTOMER":
      case "REFUNDED":
        return 4;
      default:
        return 0;
    }
  }

  String convertTypeStatus(String status) {
    switch (status) {
      case "ON_DELIVERY":
        return 'Dalam Pengiriman';
      case "WAITING_CUSTOMER_CONFIRMATION":
        return 'Sampai Tujuan';
      case 'FINISHED':
        return 'Selesai';
      case "WAITING_DELIVERY":
        return 'Menunggu Pengiriman';
      case "WAITING_PAYMENT":
        return 'Menunggu Pembayaran';
      case "WAITING_SELLER_CONFIRMATION":
        return 'Menunggu Konfirmasi Penjual';
      case "CANCELLED_BY_COURIER":
        return 'Dibatalkan Oleh Kurir';
      case "CANCELLED_BY_SELLER":
        return 'Dibatalkan Oleh Penjual';
      case "CANCELLED_BY_SYSTEM":
        return 'Dibatalkan Oleh System';
      case "CANCELLED_BY_CUSTOMER":
        return 'Dibatalkan Oleh Anda';
      case "REQUEST_REFUND_CUSTOMER":
        return 'Permintaan Pengembalian Dana';
      default:
        return 'Refunded';
    }
  }

  void countTotalPrice() {
    totalPrice = 0;
    for (Products item in detailOrderCustomer?.products ?? []) {
      totalPrice += (item.price ?? 0 * item.quantity!);
    }
  }

  void toComplain() {
    Get.toNamed(Routes.KOMPLAIN, arguments: detailOrderCustomer?.trxId);
  }

  void confirmOrder() {}

  void backToOrder() {
    if (Get.arguments[1] != null) {
      if (Get.arguments[1] == 'review') {
        print('Jalan---');
      } else if (Get.arguments[1] == 'review-detail') {
        refreshOrder();
      }
    }
    print("Jln--");
  }

  void refreshOrder() {
    final controller = Get.find<OrderController>();
    controller.pagingController.refresh();
  }

  @override
  void onInit() {
    getDetailOrder();
    super.onInit();
  }
}
