import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_bill_paylater.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../domain/core/interfaces/paylater_repository.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class DetailBillPaylaterController extends GetxController {
  final PayLaterRepository _payLaterRepository;

  DetailBillPaylaterController(this._payLaterRepository);
  DetailBillPaylater? detailBillPaylater;

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = ActionStatus.initalize;
  String statusOrder = "";
  String? argumentBack;
  int totalPrice = 0;
  bool onDelivery = false;

  Future<void> getDetailOrder() async {
    screenStatus(ScreenStatus.loading);
    final response =
        await _payLaterRepository.getDetailBillPaylater(Get.arguments[0]);
    if (response.status == StatusResponse.success) {
      detailBillPaylater = response.result;
      statusOrder = detailBillPaylater?.status ?? '';
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
      case 'REVIEWED':
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
      case 'REVIEWED':
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
    for (Products item in detailBillPaylater?.products ?? []) {
      totalPrice += (item.price ?? 0 * item.quantity!);
    }
  }

  toChoicePayment() {
    Get.toNamed(Routes.CHOICE_PAYMENT_PAYLATER,
        arguments: [Get.arguments[1], Get.arguments[2]]);
  }

  @override
  void onInit() {
    getDetailOrder();
    super.onInit();
  }
}
