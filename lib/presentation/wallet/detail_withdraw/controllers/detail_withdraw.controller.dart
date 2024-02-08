import 'package:get/get.dart';

import '../../../../domain/core/interfaces/ewallet_repository.dart';
import '../../../../domain/core/model/model_data/detail_withdraw_model.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

enum StatusWdType { waiting, success, failed }

class DetailWithdrawController extends GetxController {
  final EwalletRepository _ewalletRepository;

  DetailWithdrawController(this._ewalletRepository);

  var screenStatus = (ScreenStatus.initalize).obs;

  DetailWithdrawModel? detailWithdrawModel;

  var statusWd = StatusWdType.failed;

  Future<void> getDetailWIthdraw() async {
    screenStatus(ScreenStatus.loading);
    final response =
        await _ewalletRepository.getDetailWithdraw(id: Get.arguments);
    if (response.status == StatusResponse.success) {
      detailWithdrawModel = response.result;
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  @override
  void onInit() {
    getDetailWIthdraw();
    super.onInit();
  }
}
