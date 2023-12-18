import 'package:get/get.dart';

class EWalletController extends GetxController {
  var isShowEwallet = false.obs;

  void onShowSaldo() {
    isShowEwallet.value = !isShowEwallet.value;
  }
}
