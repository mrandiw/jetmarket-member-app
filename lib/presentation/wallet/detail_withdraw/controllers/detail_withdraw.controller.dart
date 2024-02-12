import 'package:get/get.dart';

import '../../../../domain/core/interfaces/ewallet_repository.dart';
import '../../../../domain/core/model/model_data/detail_withdraw_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';

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
        await _ewalletRepository.getDetailWithdraw(id: Get.arguments[0]);
    if (response.status == StatusResponse.success) {
      detailWithdrawModel = response.result;
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void actionBack() {
    if (Get.arguments[1] != null) {
      Get.offAllNamed(Routes.MAIN_PAGES);
      Get.put(MainPagesController());
    } else {
      Get.back();
    }
  }

  @override
  void onInit() {
    getDetailWIthdraw();
    super.onInit();
  }
}
