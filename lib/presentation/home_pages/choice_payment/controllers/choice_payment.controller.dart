import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../utils/assets/assets_images.dart';

class ChoicePaymentController extends GetxController {
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
    update();
  }

  void onChangeExpandEwallet(bool expand) {
    isEwalletExpanded = expand;
    update();
  }

  void onChangeExpandRetail(bool expand) {
    isRetailExpanded = expand;
    update();
  }

  void toCheckoutPayment(String methode) {
    Get.toNamed(Routes.CHECKOUT_PAYMENT_RETAIL,
        arguments: {'methode': methode});
  }
}
