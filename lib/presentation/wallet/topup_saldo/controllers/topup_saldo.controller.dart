import 'package:get/get.dart';

class TopupSaldoController extends GetxController {
  var selectedPaymentMethode = ''.obs;
  List<String> listPayment = ['BCA', 'BSI', 'MANDIRI', 'BRI', 'BNI'];

  void onChangePaymentMethode(String value) {
    if (selectedPaymentMethode.value.contains(value)) {
      selectedPaymentMethode('');
    } else {
      selectedPaymentMethode(value);
    }
  }
}
