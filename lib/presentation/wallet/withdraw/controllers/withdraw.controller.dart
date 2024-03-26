import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog.dart';
import 'package:jetmarket/domain/core/model/params/wallet/send_withdraw_body.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/wallet/withdraw/widget/dialog_withdraw.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/remove_comma.dart';

import '../../../../domain/core/interfaces/ewallet_repository.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class WithdrawController extends GetxController {
  final EwalletRepository _ewalletRepository;

  WithdrawController(this._ewalletRepository);

  TextEditingController nameHolderController = TextEditingController();
  TextEditingController rekeningNumberController = TextEditingController();
  TextEditingController nominalController = TextEditingController();

  var actionStatus = ActionStatus.initalize;

  bool isNameHolderNotEmpty = false;
  bool isRekeningNotEmpty = false;
  bool isNominalNotEmpty = false;
  var isNominalValue = false.obs;

  String? selectedRekening;
  String selectedNominal = '';
  List<String> rekenings = [];
  List<String> listNominal = ['50000', '100000', '150000'];

  Future<void> getRekening() async {
    final response = await _ewalletRepository.getPaymentMethode();
    if (response.status == StatusResponse.success) {
      rekenings.assignAll(response.result ?? []);
      update();
    }
  }

  void onChangeRekening(String? value) {
    selectedRekening = value ?? '';
    update();
  }

  void onChangeNominal(int index) {
    if (selectedNominal.contains(listNominal[index])) {
      selectedNominal = '';
      nominalController.text = '';
    } else {
      nominalController.text = formatNumberWithCommas(listNominal[index]);
      selectedNominal = listNominal[index];
    }
    update();
  }

  String formatNumberWithCommas(String number) {
    String numberWithCommas = number.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
    return numberWithCommas;
  }

  void listenerForm() {
    nameHolderController.addListener(() {
      if (nameHolderController.text.isNotEmpty) {
        isNameHolderNotEmpty = true;
        update();
      } else {
        isNameHolderNotEmpty = false;
        update();
      }
    });

    rekeningNumberController.addListener(() {
      if (rekeningNumberController.text.isNotEmpty) {
        isRekeningNotEmpty = true;
        update();
      } else {
        isRekeningNotEmpty = false;
        update();
      }
    });

    nominalController.addListener(() {
      if (nominalController.text.isNotEmpty) {
        isNominalNotEmpty = true;
        update();
      } else {
        isNominalNotEmpty = false;
        update();
      }
    });
  }

  void listenNominalForm(String value) {
    if (value.isNotEmpty) {
      isNominalValue(true);
    } else {
      isNominalValue(false);
    }
  }

  void changeToIdrFormat(String value) {
    nominalController.text = value.toIdrFormat;
    update();
  }

  void withdraw() {
    AppDialog.show(
        child: DialogWithdraw(
          rekening: '${rekeningNumberController.text} - $selectedRekening',
        ),
        onTesText: 'Lanjut',
        onPressed: () => sendWithdraw());
  }

  Future<void> sendWithdraw() async {
    Get.back();
    if (int.parse(nominalController.text.removeComma) > Get.arguments[0]) {
      showDialogError('Saldo anda tidak cukup');
    } else {
      actionStatus = ActionStatus.loading;
      update();
      var body = SendWithdrawBody(
          nameHolder: nameHolderController.text,
          bank: selectedRekening,
          chCode: selectedRekening,
          rekening: rekeningNumberController.text,
          amount: int.parse(nominalController.text.removeComma));
      final response = await _ewalletRepository.sendWidthdraw(body);
      if (response.status == StatusResponse.success) {
        Get.back();
        log(response.result ?? '');
        Get.toNamed(Routes.WITHDRAW_STATUS, arguments: response.result);
        actionStatus = ActionStatus.success;
        update();
      } else {
        actionStatus = ActionStatus.failed;
        update();
      }
    }
  }

  showDialogError(String message) {
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

  @override
  void onInit() {
    getRekening();
    listenerForm();
    super.onInit();
  }
}
