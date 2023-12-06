import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

class WaitingPaymentController extends GetxController {
  void toCaraBayar() {
    Get.toNamed(Routes.CARA_BAYAR);
  }
}
