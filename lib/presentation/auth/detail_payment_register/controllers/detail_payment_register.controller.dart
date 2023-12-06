import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/argument/payment_methode_argument.dart';
import 'package:jetmarket/domain/core/model/params/auth/payment_param.dart';

import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../domain/core/model/model_data/payment_customer_model.dart';
import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

enum PaymentMethodeType { va, retail, qris, wallet }

class DetailPaymentRegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AuthRepository _authRepository;

  DetailPaymentRegisterController(this._authRepository);
  TextEditingController numberController = TextEditingController();
  var screenStatus = (ScreenStatus.initalize).obs;
  var methodeType = PaymentMethodeType.va;
  PaymentMethodeArgument? argument;
  PaymentCustomerModel? paymentCustomer;
  TutorialPaymentVaModel? tutorialPayment;
  late TabController tabController;

  Future<void> createPaymentCustomer() async {
    var param =
        PaymentParam(id: argument?.id ?? 0, amount: argument?.amount ?? '');
    screenStatus(ScreenStatus.loading);
    final response = await _authRepository.createPaymentCustomer(param);
    if (response.status == StatusResponse.success) {
      paymentCustomer = response.result;
      if (paymentCustomer?.channel?.type == 'EWALLET') {
        methodeType = PaymentMethodeType.wallet;
      } else if (paymentCustomer?.channel?.type == 'RETAIL') {
        methodeType = PaymentMethodeType.retail;
      } else if (paymentCustomer?.channel?.type == 'QRIS') {
        methodeType = PaymentMethodeType.qris;
      } else {
        methodeType = PaymentMethodeType.va;
      }
      screenStatus(ScreenStatus.success);
      update();
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  getTutorial() async {
    final response = await _authRepository.fetchDataFromJsonFile('bjb');
    // ignore: unnecessary_null_comparison
    if (response != null) {
      tutorialPayment = response;
      update();
      print(tutorialPayment?.tab1?[0].title);
    }
  }

  String assetImage(String path) {
    return "assets/images/$path.png";
  }

  void toRegisterPage() {
    // final registerController =
    //     Get.put(RegisterController(AuthRepositoryImpl()));
    // registerController.selectedPaymentMethode.value = "BNI";
    // Get.back();
    // Get.back();
  }

  @override
  void onInit() {
    argument = Get.arguments;
    // createPaymentCustomer();
    getTutorial();
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}
