import 'package:get/get.dart';

import '../../../../domain/core/interfaces/saving_repository.dart';
import '../../../../domain/core/model/model_data/detail_saving_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';

class DetailMenabungController extends GetxController {
  final SavingRepository _savingRepository;
  DetailMenabungController(this._savingRepository);

  DetailSavingModel? detailSaving;

  var screenStatus = ScreenStatus.initalize.obs;

  Future<void> getSavingDetail() async {
    screenStatus(ScreenStatus.loading);
    final response = await _savingRepository.getDetailSaving(Get.arguments[0]);
    if (response.status == StatusResponse.success) {
      screenStatus(ScreenStatus.success);
      detailSaving = response.result;
      update();
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
    getSavingDetail();
    super.onInit();
  }
}
