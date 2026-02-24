// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/domain/core/interfaces/auth_repository.dart';
import 'package:jetmarket/domain/core/interfaces/payment_repository.dart';
import 'package:jetmarket/domain/core/model/argument/payment_methode_argument.dart';
import 'package:jetmarket/domain/core/model/model_data/payment_methode_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/payment_register/widget/ovo_form.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../components/dialog/dialog_noconnection.dart';
import '../../../../domain/core/model/model_data/payment_customer_model.dart';
import '../../../../domain/core/model/params/auth/payment_param.dart';
import '../../../../utils/extension/payment_methode_type.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class PaymentRegisterController extends GetxController {
  final PaymentRepository _paymentRepository;

  PaymentRegisterController(this._paymentRepository, this._authRepository);

  TextEditingController numberController = TextEditingController();
  var screenStatus = (ScreenStatus.initalize).obs;
  var actionStatus = ActionStatus.initalize;
  PaymentMethodeModel? paymentMethodes;
  String selectedBankTransfer = "";
  String selectedEwallet = "";
  String selectedRetail = "";
  String selectedchType = "";
  String selectedchCode = "";
  String selectedName = "";
  String selectedPricing = "";
  final String countryCode = '+62';
  final totalAmount = "0".obs;
  final AuthRepository _authRepository;
  var actionClaimStatus = ActionStatus.initalize;
  var biayaRegistrasi = ''.obs;
  var biayaRegistrasiPromo = ''.obs;
  var referralMessage = ''.obs;
  TextEditingController referralController = TextEditingController();

  Future<void> checkReferralCode() async {
    try {
      actionClaimStatus = ActionStatus.loading;
      update();
      final response =
          await _authRepository.claimReferral(referralController.text);
      if (response.status == StatusResponse.success) {
        fetchCost('MEMBER_DISCOUNT_REFFERAL', true);
      } else {
        referralMessage.value = "Kode Referal Tidak Terdaftar";
        actionClaimStatus = ActionStatus.success;
      }
    } catch (e) {
      referralMessage.value = "Kode Referal Tidak Terdaftar";
      actionClaimStatus = ActionStatus.success;
    }
  }

  Future<void> fetchCost(String code, bool isPromo) async {
    final response = await _authRepository.generalConfigCode(code: code);
    if (response.status == StatusResponse.success) {
      if (isPromo) {
        totalAmount.value = response.result?.value ?? '0';
        biayaRegistrasiPromo.value = response.result?.value ?? '0';
        AppPreference().setBiayaRegisPromo(response.result?.value ?? '0');
      } else {
        totalAmount.value = response.result?.value ?? '0';
        biayaRegistrasi.value = response.result?.value ?? '0';
        AppPreference().setBiayaRegis(response.result?.value ?? '0');
      }
      actionClaimStatus = ActionStatus.success;
      update();
    }
  }

  void getRegistrasiAmount() {
    String amount = AppPreference().cekReferal() == true
        ? AppPreference().getBiayaRegisPromo() ?? '0'
        : AppPreference().getBiayaRegis() ?? '0';

    if (amount == "0") {
      totalAmount.value = "0";
    } else {
      totalAmount.value = "0";
      // totalAmount.value = amount;
    }
    update();
  }

  bool isBankTransferExpanded = false;
  bool isEwalletExpanded = false;
  bool isRetailExpanded = false;
  var isPhoneValidated = false.obs;

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

  Future<void> getPaymentMethode() async {
    screenStatus(ScreenStatus.loading);
    final response = await _paymentRepository.getPaymentMethode(
        type: PaymentMethodeType.register);
    if (response.result?.ewalletQr != null &&
        response.result?.otc != null &&
        response.result?.virtualAccount != null) {
      {
        if (response.status == StatusResponse.success) {
          paymentMethodes = response.result;
          update();
          screenStatus(ScreenStatus.success);
        } else if (response.status == StatusResponse.noInternet) {
          if (!(Get.isDialogOpen ?? false)) {
            DialogNoConnection.show(onReload: () {
              Get.back();
              getPaymentMethode();
            });
          }
        } else {
          AppSnackbar.show(message: response.message, type: SnackType.error);
          screenStatus(ScreenStatus.failed);
        }
      }
    } else {
      AppSnackbar.show(message: 'Something went wrong', type: SnackType.error);
      screenStatus(ScreenStatus.failed);
    }
  }

  Future<void> createPaymentCustomer() async {
    actionStatus = ActionStatus.loading;
    update();

    // String phoneNumber = AppPreference().getPhoneNumber() ?? '';
    var param = PaymentParam(
        chType: selectedchType,
        chCode: selectedchCode,
        amount: totalAmount.value,
        mobileNumber: isPhoneValidated.value ? numberController.text : null);
    final response = await _paymentRepository.createPaymentCustomer(param);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      log("TRXXX : ${response.result?.id}");
      toPaying(response.result, totalAmount.value);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Error',
              desc: response.message,
              titleTextStyle: text16BlackSemiBold,
              descTextStyle: text12BlackRegular,
              btnCancelOnPress: () {})
          .show();
    }
  }

  String assetImage(String path) {
    return "assets/images/${path.toLowerCase()}.png";
  }

  void actionPayment(
      String chType, String chCode, String name, String pricing) {
    selectedBankTransfer = chCode;
    selectedEwallet = chCode;
    selectedRetail = chCode;
    selectedchType = chType;
    selectedchCode = chCode;
    selectedName = name;
    selectedPricing = pricing;
    update();
    if (chType == "EWALLET" && chCode == "OVO") {
      CustomBottomSheet.show(
          child: OvoForm(
        controller: this,
      ));
    }
  }

  void toPaying(PaymentCustomerModel? data, String amount) async {
    var argument = PaymentMethodeArgument(
        status: "register",
        amount: amount,
        chType: selectedchType,
        chCode: selectedchCode,
        name: selectedName,
        data: data);
    await AppPreference().saveTrxId(data?.id ?? 0);
    Get.toNamed(Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
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

  String calculateSelectedPricing() {
    if (selectedPricing.contains('%')) {
      double percentage =
          double.parse(selectedPricing.replaceAll('%', '').trim());

      double biayaLayanan = (int.parse(totalAmount.value) * percentage) / 100;
      return biayaLayanan.toStringAsFixed(0).toIdrFormat;
    } else {
      return selectedPricing.toIdrFormat;
    }
  }

  String calculateTotalPayment() {
    double biayaLayanan = 0.0;

    if (selectedPricing.contains('%')) {
      double percentage =
          double.parse(selectedPricing.replaceAll('%', '').trim());
      biayaLayanan = (int.parse(totalAmount.value) * percentage) / 100;
    } else {
      biayaLayanan = double.tryParse(selectedPricing) ?? 0.0;
    }

    double totalPembayaran = int.parse(totalAmount.value) + biayaLayanan;
    return totalPembayaran.toStringAsFixed(0);
  }

  @override
  void onInit() {
    numberController.text = countryCode;
    numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: numberController.text.length));
    getRegistrasiAmount();
    getPaymentMethode();
    super.onInit();
  }
}
