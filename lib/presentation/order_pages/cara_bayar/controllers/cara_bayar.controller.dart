import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/core/interfaces/payment_repository.dart';
import '../../../../domain/core/model/model_data/order_customer_payment.dart';
import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../utils/network/screen_status.dart';

enum PaymentMethodeType { va, retail, qris, wallet }

class CaraBayarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PaymentRepository _paymentRepository;
  final OrderRepository _orderRepository;

  CaraBayarController(this._paymentRepository, this._orderRepository);
  int lenghTabs = 0;
  TextEditingController numberController = TextEditingController();
  var screenStatus = (ScreenStatus.initalize).obs;
  var methodeType = PaymentMethodeType.va;
  OrderCustomerPaymentModel? paymentCustomer;
  TutorialPaymentVaModel? tutorialPayment;
  TabController? tabController;
  List<String> assetsImageForQrisScreen = [
    'assets/images/ovo.png',
    'assets/images/gopay.png',
    'assets/images/shopeepay.png',
    'assets/images/linkaja.png',
    'assets/images/dana.png'
  ];

  Future<void> getPaymentOrderCustomer() async {
    screenStatus(ScreenStatus.loading);
    final response = await _orderRepository.getPaymentTutorial(Get.arguments);
    if (response.status == StatusResponse.success) {
      paymentCustomer = response.result;
      if (paymentCustomer?.channel?.type == 'EWALLET') {
        methodeType = PaymentMethodeType.wallet;
      } else if (paymentCustomer?.channel?.type == 'OTC') {
        String? lowerCaseCode = paymentCustomer?.channel?.code?.toLowerCase();
        getTutorial(lowerCaseCode ?? '');
        methodeType = PaymentMethodeType.retail;
      } else if (paymentCustomer?.channel?.type == 'QR_CODE') {
        methodeType = PaymentMethodeType.qris;
      } else {
        String? lowerCaseCode = paymentCustomer?.channel?.code?.toLowerCase();

        getTutorial(lowerCaseCode ?? '');
        methodeType = PaymentMethodeType.va;
      }
      screenStatus(ScreenStatus.success);

      update();
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  getTutorial(String path) async {
    final response = await _paymentRepository.fetchDataFromJsonFile(path);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      tutorialPayment = response;
      lenghTabs = tutorialPayment?.tabs?.length ?? 0;
      tabController = TabController(length: lenghTabs, vsync: this);
      update();
    }
  }

  String assetImage(String path) {
    return "assets/images/$path.png";
  }

  void copyVa(String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.vibrate();
  }

  void onTapQrCode(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  void onInit() {
    getPaymentOrderCustomer();
    super.onInit();
  }
}
