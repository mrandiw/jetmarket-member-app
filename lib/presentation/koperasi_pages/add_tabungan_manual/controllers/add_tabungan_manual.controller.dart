import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_payment_methode_model.dart';
import 'package:jetmarket/domain/core/model/params/saving/saving_direct_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/remove_comma.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../domain/core/interfaces/saving_repository.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../widget/confirmation_saving_saldo.dart';
import '../widget/ovo_form.dart';

class AddTabunganManualController extends GetxController {
  final SavingRepository _savingRepository;
  AddTabunganManualController(this._savingRepository);

  TextEditingController nominalController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = ActionStatus.initalize;

  SavingPaymentMethodeModel? savingPaymentMethode;

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
  int? selectedIdMethode;

  var isPhoneValidated = false.obs;

  Future<void> getSavingPaymentMethode() async {
    screenStatus.value = ScreenStatus.loading;
    final repository = await _savingRepository.getSavingPaymentMethode();
    if (repository.status == StatusResponse.success) {
      savingPaymentMethode = repository.result;
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
    selectedChCode = savingPaymentMethode?.saldo?.chCode;
    selectedChType = 'SALDO';
    update();
  }

  Future<void> savingDirect() async {
    actionButton = ActionStatus.loading;
    update();
    var param = SavingDirectParam(
        amount: int.parse(nominalController.text.removeComma),
        chCode: selectedChCode,
        chType: selectedChType);
    final response = await _savingRepository.savingDirect(param);
    if (response.status == StatusResponse.success) {
      actionButton = ActionStatus.success;
      update();
      if (selectedChCode == 'saldo') {
        Get.offNamed(Routes.PAYMENT_TABUNGAN_SUCCESS,
            arguments: response.result);
      } else {
        Get.offNamed(Routes.TABUNGAN_PAYMENT);
      }
    } else {
      actionButton = ActionStatus.failed;
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

  @override
  void onInit() {
    getSavingPaymentMethode();
    numberController.text = countryCode;
    numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: numberController.text.length));
    super.onInit();
  }
}
