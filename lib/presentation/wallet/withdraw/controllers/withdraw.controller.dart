import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog.dart';
import 'package:jetmarket/domain/core/model/params/wallet/send_withdraw_body.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/wallet/withdraw/widget/dialog_withdraw.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/remove_comma.dart';

import '../../../../domain/core/interfaces/ewallet_repository.dart';
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
      nominalController.text = listNominal[index];
      selectedNominal = listNominal[index];
    }
    update();
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
      Get.offNamed(Routes.WITHDRAW_STATUS, arguments: response.result);
      actionStatus = ActionStatus.success;
      update();
    } else {
      actionStatus = ActionStatus.failed;
      update();
    }
  }

  @override
  void onInit() {
    getRekening();
    listenerForm();
    super.onInit();
  }
}
