import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/interfaces/payment_repository.dart';
import '../../../../domain/core/model/model_data/order_customer.dart';
import '../../../../domain/core/model/model_data/payment_payletter.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class PaymentPayletterController extends GetxController {
  final PaymentRepository _paymentRepository;
  final OrderRepository _orderRepository;
  PaymentPayletterController(this._paymentRepository, this._orderRepository);

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionStatus = ActionStatus.initalize;
  OrderCustomerModel? orderCustomer;
  PaymentPayletter? paymentPayletter;

  var aggreSkPayletter = false.obs;
  int? seledtedPayleterIndex;

  setDataArgument(String? chCode, String? chType) {
    if (chCode != null) {
      orderCustomer = Get.arguments;
      orderCustomer?.chCode = chCode;
      orderCustomer?.chType = chType;
      update();
    }
    orderCustomer = Get.arguments;

    log(orderCustomer?.toJson().toString() ?? '');
  }

  Future<void> payOrder() async {
    actionStatus = ActionStatus.loading;
    update();

    final response = await _orderRepository.orderCustomerPayment(orderCustomer);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      Get.toNamed(Routes.PAYLETTER_SUCCESS, arguments: response.result?.refId);
      log(response.result?.orderId.toString() ?? '');
    } else {
      actionStatus = ActionStatus.failed;
      update();
    }
    log(orderCustomer!.toJson().toString());
  }

  Future<void> getPayleter(int amount, String? chCode, String chType) async {
    screenStatus(ScreenStatus.loading);
    final response = await _paymentRepository.getPaymentPayletter(amount);
    if (response.status == StatusResponse.success) {
      if (response.result != null) {
        paymentPayletter = response.result;
        seledtedPayleterIndex = paymentPayletter?.installments
                ?.indexWhere((e) => e.chCode == chCode && e.chType == chType) ??
            0;
        selectPayleter(seledtedPayleterIndex ?? 0);
        update();
      } else {
        AwesomeDialog(
            dismissOnTouchOutside: false,
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Pembayaran Gagal',
            desc: response.message,
            titleTextStyle: text16BlackSemiBold,
            descTextStyle: text12BlackRegular,
            btnCancelText: 'Kambali',
            btnCancelOnPress: () => Get.back()).show();
      }
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void selectPayleter(int index) {
    seledtedPayleterIndex = index;
    setDataArgument(paymentPayletter?.installments?[index].chCode,
        paymentPayletter?.installments?[index].chType);
    update();
  }

  void changeAggreSkPayletter(bool value) {
    aggreSkPayletter.value = value;
    update();
  }

  @override
  void onInit() {
    setDataArgument(null, null);
    getPayleter(orderCustomer?.totalAmount ?? 0, orderCustomer?.chCode,
        orderCustomer?.chType ?? '');
    super.onInit();
  }
}
