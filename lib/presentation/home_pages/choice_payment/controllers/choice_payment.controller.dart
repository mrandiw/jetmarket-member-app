import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';
import 'package:jetmarket/domain/core/interfaces/payment_repository.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/model/model_data/order_customer.dart';
import '../../../../domain/core/model/model_data/payment_methode_model.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/extension/payment_methode_type.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';
import '../../../order_pages/order/controllers/order.controller.dart';
import '../widget/confirmation_saving_saldo.dart';
import '../widget/ovo_form.dart';

class ChoicePaymentController extends GetxController {
  final PaymentRepository _paymentRepository;
  final OrderRepository _orderRepository;
  ChoicePaymentController(this._paymentRepository, this._orderRepository);
  TextEditingController numberController = TextEditingController();

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionStatus = ActionStatus.initalize;
  OrderCustomerModel? orderCustomer;
  PaymentMethodeModel? paymentMethodes;
  String selectedBankTransfer = "";
  String selectedEwallet = "";
  String selectedRetail = "";
  String selectedPayletter = "";

  int selectedId = 0;
  String selectedchType = "";
  String selectedchCode = "";
  String selectedName = "";
  final String countryCode = '+62';

  bool isBankTransferExpanded = false;
  bool isEwalletExpanded = false;
  bool isRetailExpanded = false;
  bool isPayletterExpanded = false;
  var isPhoneValidated = false.obs;
  var isPaymentSaldoSuccessed = false.obs;

  List<dynamic> listChoicePayletter = [
    {
      'id': 100,
      'title': 'Beli Sekarang Bayar Nanti',
    },
    {
      'id': 101,
      'title': 'Cicilan 3x',
    },
    {
      'id': 102,
      'title': 'Cicilan 6x',
    },
    {
      'id': 103,
      'title': 'Cicilan 12x',
    }
  ];

  void onChangeExpandBank(bool expand) {
    isBankTransferExpanded = expand;
    selectedBankTransfer = "";
    update();
  }

  void onChangeExpandEwallet(bool expand) {
    isEwalletExpanded = expand;
    selectedEwallet = "";
    update();
  }

  void onChangeExpandRetail(bool expand) {
    isRetailExpanded = expand;
    selectedRetail = "";
    update();
  }

  void onChangeExpandPayletter(bool expand) {
    isPayletterExpanded = expand;
    selectedPayletter = "";
    update();
  }

  Future<void> getPaymentMethode() async {
    screenStatus(ScreenStatus.loading);
    final response = await _paymentRepository.getPaymentMethode(
        type: PaymentMethodeType.order);
    if (response.result?.ewalletQr != null &&
        response.result?.otc != null &&
        response.result?.virtualAccount != null) {
      {
        if (response.status == StatusResponse.success) {
          paymentMethodes = response.result;
          update();
          screenStatus(ScreenStatus.success);
        } else {
          screenStatus(ScreenStatus.failed);
          showDialog(response.message, true);
        }
      }
    } else {
      AppSnackbar.show(message: 'Something went wrong', type: SnackType.error);
      screenStatus(ScreenStatus.failed);
    }
  }

  String assetImage(String path) {
    return "assets/images/${path.toLowerCase()}.png";
  }

  void confirmationDialogSavingSaldo() {
    AppDialogConfirmationSaving.show(controller: this);
  }

  void confirmationSavingSaldo() {
    Get.back();
    if ((orderCustomer?.totalAmount ?? 0) <=
        (paymentMethodes?.saldo?[0].amount ?? 0)) {
      payOrder();
    } else {
      showDialog('Saldo tidak cukup', true);
    }
  }

  void actionPayment(int id, String chType, String chCode, String name) {
    selectedBankTransfer = id.toString();
    selectedEwallet = id.toString();
    selectedRetail = id.toString();
    selectedPayletter = id.toString();
    selectedId = id;
    selectedchType = chType;
    selectedchCode = chCode;
    selectedName = name;
    setDataArgument();
    update();
    if (chType == "EWALLET" && chCode == "OVO") {
      CustomBottomSheet.show(
          child: OvoForm(
        controller: this,
      ));
    } else if (chType == "SALDO" && chCode == "SALDO") {
      confirmationDialogSavingSaldo();
    }
  }

  List<TextInputFormatter> formaterNumber() => [
        LengthLimitingTextInputFormatter(countryCode.length + 12),
        FilteringTextInputFormatter.deny(RegExp(r'[^\d+]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.startsWith(countryCode)) {
            return newValue;
          }
          return oldValue;
        }),
      ];

  listenPhoneForm(String value) {
    if (value.startsWith('${countryCode}0') &&
        value.length > (countryCode.length + 1)) {
      numberController.text =
          countryCode + value.substring(countryCode.length + 1);
      numberController.selection = TextSelection.fromPosition(
          TextPosition(offset: numberController.text.length));
      update();
    }
    if (value.length >= 9) {
      isPhoneValidated(true);
    } else {
      isPhoneValidated(false);
    }
  }

  String getImage(String image) {
    String img;
    try {
      img = 'assets/images/${image.toLowerCase()}.png';
    } catch (e) {
      img = 'assets/images/warning.png';
    }
    return img;
  }

  setDataArgument() {
    List<dynamic> items = Get.arguments[4]['items'];
    orderCustomer = OrderCustomerModel(
        addressId: Get.arguments[0],
        voucherId: Get.arguments[1],
        mobileNumber: Get.arguments[2],
        totalAmount: Get.arguments[3],
        chCode: selectedchCode,
        chType: selectedchType,
        items: items.map((e) => Items.fromJson(e)).toList());
  }

  Future<void> payOrder() async {
    if (selectedchType == 'PAYLATER') {
      Get.toNamed(Routes.PAYMENT_PAYLETTER, arguments: orderCustomer);
    } else {
      actionStatus = ActionStatus.loading;
      update();
      log(orderCustomer?.toJson().toString() ?? '');
      final response =
          await _orderRepository.orderCustomerPayment(orderCustomer);
      if (response.status == StatusResponse.success) {
        actionStatus = ActionStatus.success;
        update();
        if (selectedchType == 'SALDO') {
          isPaymentSaldoSuccessed(true);
          showDialog(response.message, false);
          log(response.result?.toJson().toString() ?? '');
        } else {
          Get.offAllNamed(Routes.CHECKOUT_PAYMENT, arguments: response.result);
        }
      } else {
        actionStatus = ActionStatus.failed;
        update();
        showDialog(response.message, true);
      }
    }
  }

  void showDialog(String? message, bool? isError) {
    AwesomeDialog(
            context: Get.context!,
            dialogType: isError == true ? DialogType.error : DialogType.success,
            animType: AnimType.rightSlide,
            title: isError == true ? 'Error' : 'Success',
            desc: message,
            titleTextStyle: text16BlackSemiBold,
            descTextStyle: text12BlackRegular,
            btnOkOnPress: isError == false ? () {} : null,
            btnOkText: isError == false ? 'Lihat Pesanan' : null,
            btnCancelOnPress: isError == true ? () {} : null)
        .show()
        .whenComplete(() async {
      if (isError == false) {
        await Future.delayed(300.milliseconds, () {
          backtoMerchent();
        });
      }
    });
  }

  void backtoMerchent() {
    Get.back();
    Get.back();
    Get.back();
    Get.find<MainPagesController>().changeTabIndex(1);
    Get.find<OrderController>().getWaitingOrderLenght();
    Get.find<OrderController>().pagingController.refresh();
  }

  @override
  void onInit() {
    setDataArgument();
    numberController.text = countryCode;
    numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: numberController.text.length));
    getPaymentMethode();
    super.onInit();
  }
}
