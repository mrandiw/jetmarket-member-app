import 'package:get/get.dart';

class VoucherController extends GetxController {
  List<dynamic> vouchers = [];
  int selectedVoucher = 99;

  void selectVoucher(int value) {
    if (selectedVoucher != value) {
      selectedVoucher = value;
      update();
    } else {
      selectedVoucher = 99;
      update();
    }
  }

  @override
  void onInit() {
    vouchers = List.generate(
        3,
        (index) => {
              "title": "Gratis Ongkir ${index + 1}",
              "subtitle": 'Min. Belanja Rp30RB'
            });
    super.onInit();
  }
}
