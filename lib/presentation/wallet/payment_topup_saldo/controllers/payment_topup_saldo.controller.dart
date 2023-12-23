import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/product_repository.dart';

import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';

class PaymentTopupSaldoController extends GetxController {
  final ProductRepository _productRepository;
  PaymentTopupSaldoController(this._productRepository);
  TutorialPaymentVaModel? tutorialPayment;

  getTutorial(String path) async {
    final response = await _productRepository.fetchDataFromJsonFile(path);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      tutorialPayment = response;
      update();
    }
  }

  void copyVa(String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.vibrate();
  }

  @override
  void onInit() {
    getTutorial('mandiri');
    super.onInit();
  }
}
