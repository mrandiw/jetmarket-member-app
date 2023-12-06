import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/domain/core/interfaces/auth_repository.dart';
import 'package:jetmarket/domain/core/model/argument/payment_methode_argument.dart';
import 'package:jetmarket/domain/core/model/model_data/payment_methode_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/auth/payment_register/widget/ovo_form.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';

import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class PaymentRegisterController extends GetxController {
  final AuthRepository _authRepository;

  PaymentRegisterController(this._authRepository);
  TextEditingController numberController = TextEditingController();
  var screenStatus = (ScreenStatus.initalize).obs;
  PaymentMethodeModel? paymentMethodes;
  String selectedBankTransfer = "";
  String selectedEwallet = "";
  String selectedRetail = "";

  List<String> banks = [
    bca,
    bni,
    mandiri,
    bri,
    bsi,
    bca,
    bni,
    mandiri,
    bri,
    bsi
  ];
  List<String> ewallets = [dana, ovo];

  List<String> retail = [indomaret, alfamart];

  bool isBankTransferExpanded = false;
  bool isEwalletExpanded = false;
  bool isRetailExpanded = false;

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
    final response = await _authRepository.getPaymentMethode();
    if (response.status == StatusResponse.success) {
      paymentMethodes = response.result;
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  String assetImage(String path) {
    return "assets/images/$path.png";
  }

  void actionPayment(int id, String chType, String chCode, String name) {
    selectedBankTransfer = chCode;
    selectedEwallet = chCode;
    selectedRetail = chCode;
    print(chCode);
    update();
    if (chType == "EWALLET" && chCode == "OVO") {
      CustomBottomSheet.show(
          child: OvoForm(
        controller: this,
      ));
    } else {
      var argument = PaymentMethodeArgument(
          id: id, amount: '10000', chType: chType, chCode: chCode, name: name);
      Get.toNamed(Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
    }
  }

  @override
  void onInit() {
    getPaymentMethode();
    super.onInit();
  }
}
