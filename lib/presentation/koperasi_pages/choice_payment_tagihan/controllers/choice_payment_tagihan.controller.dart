import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_bill.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../domain/core/interfaces/payment_repository.dart';
import '../../../../domain/core/model/model_data/payment_methode_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/extension/payment_methode_type.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../widget/confirmation_saving_saldo.dart';
import '../widget/ovo_form.dart';

class ChoicePaymentTagihanController extends GetxController {
  final LoanRepository _loanRepository;
  final PaymentRepository _paymentRepository;
  ChoicePaymentTagihanController(this._loanRepository, this._paymentRepository);

  TextEditingController numberController = TextEditingController();

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = ActionStatus.initalize;

  PaymentMethodeModel? savingPaymentMethode;

  final String countryCode = '+62';
  final String idrPrefix = 'Rp. ';

  bool isBankTransferExpanded = false;
  bool isEwalletExpanded = false;
  bool isRetailExpanded = false;
  String selectedBankTransfer = "";
  String selectedEwallet = "";
  String selectedRetail = "";
  String? selectedChType;
  String? selectedChCode;
  String selectedName = "";
  int? selectedIdMethode;

  var isPhoneValidated = false.obs;

  Future<void> getSavingPaymentMethode() async {
    screenStatus.value = ScreenStatus.loading;
    final response = await _paymentRepository.getPaymentMethode(
        type: PaymentMethodeType.biling);
    if (response.status == StatusResponse.success) {
      savingPaymentMethode = response.result;
      screenStatus.value = ScreenStatus.success;
      update();
    } else {
      screenStatus.value = ScreenStatus.failed;
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

  String assetImage(String path) {
    return "assets/images/${path.toLowerCase()}.png";
  }

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

  void actionPayment(int id, String chType, String chCode, String name) {
    selectedBankTransfer = id.toString();
    selectedEwallet = id.toString();
    selectedRetail = id.toString();
    selectedIdMethode = id;
    selectedChType = chType;
    selectedChCode = chCode;
    update();
    if (chType == "EWALLET" && chCode == "OVO") {
      CustomBottomSheet.show(
          child: OvoForm(
        controller: this,
      ));
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

  void confirmationDialogSavingSaldo() {
    AppDialogConfirmationSaving.show(controller: this);
  }

  void selectSaldoPayment() {
    selectedChCode = savingPaymentMethode?.saldo?[0].chCode ?? '';
    selectedChType = savingPaymentMethode?.saldo?[0].chType ?? '';
    update();
  }

  void confirmationSavingSaldo() {
    Get.back();
    if ((Get.arguments[1] ?? 0) <=
        (savingPaymentMethode?.saldo?[0].amount ?? 0)) {
      selectSaldoPayment();
      payementBill();
    } else {
      errorDialogMessage('Saldo tidak cukup');
    }
  }

  void errorDialogMessage(String message) {
    AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: message,
            titleTextStyle: text16BlackSemiBold,
            descTextStyle: text12BlackRegular,
            btnCancelOnPress: () {})
        .show();
  }

  // void confirmationDialogSavingSaldo() {
  //   AppDialogConfirmationSaving.show(controller: this);
  // }

  Future<void> payementBill() async {
    actionButton = ActionStatus.loading;
    update();
    var param = LoanBillParam(
        refId: Get.arguments[0],
        amount: Get.arguments[1],
        chCode: selectedChCode,
        chType: selectedChType,
        mobileNumber: numberController.text);
    final response = await _loanRepository.loanBill(param);
    if (response.status == StatusResponse.success) {
      actionButton = ActionStatus.success;
      update();
      // isPayment = true;
      Get.offAllNamed(Routes.TAGIHAN_PAYMENT_BILL, arguments: response.result);
    } else {
      actionButton = ActionStatus.failed;
      update();
      errorDialogMessage(response.message ?? '');
    }
  }

  // void confirmationSavingSaldo() {
  //   Get.back();
  //   if (int.parse(nominalController.text.removeComma) <=
  //       (savingPaymentMethode?.saldo?[0].amount ?? 0)) {
  //     selectSaldoPayment();
  //     savingDirect();
  //   } else {
  //     errorDialogMessage('Saldo tidak cukup');
  //   }
  // }

  @override
  void onInit() {
    getSavingPaymentMethode();
    numberController.text = countryCode;
    numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: numberController.text.length));
    super.onInit();
  }
}
