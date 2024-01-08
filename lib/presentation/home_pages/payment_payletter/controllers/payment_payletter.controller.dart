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

  setDataArgument(int? paymentId) {
    if (paymentId != null) {
      orderCustomer = Get.arguments;
      orderCustomer?.paymentMethodId = paymentId;
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
      Get.toNamed(Routes.PAYLETTER_SUCCESS,
          arguments: response.result?.orderId);
    } else {
      actionStatus = ActionStatus.failed;
      update();
    }
  }

  Future<void> getPayleter(int amount, int? id) async {
    screenStatus(ScreenStatus.loading);
    final response = await _paymentRepository.getPaymentPayletter(amount);
    if (response.status == StatusResponse.success) {
      if (response.result != null) {
        paymentPayletter = response.result;
        seledtedPayleterIndex =
            paymentPayletter?.installments?.indexWhere((e) => e.id == id);
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
    setDataArgument(paymentPayletter?.installments?[index].id);
    update();
  }

  void changeAggreSkPayletter(bool value) {
    aggreSkPayletter.value = value;
    update();
  }

  @override
  void onInit() {
    setDataArgument(null);
    getPayleter(
        orderCustomer?.totalAmount ?? 0, orderCustomer?.paymentMethodId);
    super.onInit();
  }
}
