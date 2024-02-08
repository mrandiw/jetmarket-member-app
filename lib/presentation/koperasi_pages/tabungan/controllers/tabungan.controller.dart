import 'package:get/get.dart';

import '../../../../domain/core/interfaces/saving_repository.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class TabunganController extends GetxController {
  final SavingRepository _savingRepository;
  TabunganController(this._savingRepository);

  var screenStatus = ScreenStatus.initalize.obs;

  Future<void> waitingPayment() async {
    screenStatus(ScreenStatus.loading);
    final response = await _savingRepository.waitingPayment();
    if (response.status == StatusResponse.success) {
      screenStatus(ScreenStatus.success);
      if (response.result?.id != null) {
        Get.offNamed(Routes.TABUNGAN_PAYMENT, arguments: response.result);
      }
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  @override
  void onInit() {
    // waitingPayment();
    super.onInit();
  }
}
