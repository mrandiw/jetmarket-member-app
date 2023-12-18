import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/wallet/withdraw/widget/dialog_withdraw.dart';
import 'package:jetmarket/utils/extension/currency.dart';

class WithdrawController extends GetxController {
  TextEditingController rekeningNumberController = TextEditingController();
  TextEditingController nominalController = TextEditingController();

  bool isRekeningNotEmpty = false;
  bool isNominalNotEmpty = false;

  String? selectedRekening;
  String selectedNominal = '';
  List<String> rekenings = ['BCA', 'BSI', 'MANDIRI'];
  List<String> listNominal = ['50000', '100000', '150000'];

  void onChangeRekening(String? value) {
    selectedRekening = value ?? '';
    update();
  }

  void onChangeNominal(int index) {
    if (selectedNominal.contains(listNominal[index])) {
      selectedNominal = '';
      nominalController.text = '';
    } else {
      nominalController.text = listNominal[index].toIdrFormat;
      selectedNominal = listNominal[index];
    }
    update();
  }

  void listenerForm() {
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

  void changeToIdrFormat(String value) {
    nominalController.text = value.toIdrFormat;
    update();
  }

  void withdraw() {
    AppDialog.show(
        child: const DialogWithdraw(
          rekening: '4273847774922 - BCA John Doe',
        ),
        onTesText: 'Lanjut',
        onPressed: () {
          Get.back();
          Get.offNamed(Routes.WITHDRAW_STATUS);
        });
  }

  @override
  void onInit() {
    listenerForm();
    super.onInit();
  }
}
