import 'package:get/get.dart';

class PaymentStatusController extends GetxController {
  var statusPayment = false.obs;

  Future<void> checkStatus() async {
    await Future.delayed(4.seconds, () {
      statusPayment(true);
    });
  }
}
