import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';

class CheckoutController extends GetxController {
  List<dynamic> deliverys = [];
  int selectedDelivery = 99;

  void selectDelivery(int value) {
    if (selectedDelivery != value) {
      selectedDelivery = value;
      update();
    } else {
      selectedDelivery = 99;
      update();
    }
  }

  void toChoicePayment() {
    Get.toNamed(Routes.CHOICE_PAYMENT);
  }

  @override
  void onInit() {
    deliverys = List.generate(
        3,
        (index) => {
              "name": "Pengiriman ${index + 1}",
              "price": 20000,
              "estimasi": "16 - 20"
            });
    super.onInit();
  }
}
