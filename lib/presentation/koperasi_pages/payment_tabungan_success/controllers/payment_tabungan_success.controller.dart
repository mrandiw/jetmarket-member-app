import 'package:get/get.dart';

import '../../../../domain/core/model/model_data/saving_direct_model.dart';

class PaymentTabunganSuccessController extends GetxController {
  SavingDirectModel? savingDirect;

  @override
  void onInit() {
    savingDirect = Get.arguments;
    super.onInit();
  }
}
