import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/paylater_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_paylater_model.dart';
import 'package:jetmarket/utils/network/screen_status.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/status_response.dart';

class PaylaterCustomerController extends GetxController {
  final PayLaterRepository _payLaterRepository;

  PaylaterCustomerController(this._payLaterRepository);

  var screenStatus = ScreenStatus.success.obs;

  DetailPaylaterModel? detailPaylater;

  Future<void> getDetailPaylater() async {
    screenStatus(ScreenStatus.loading);
    final response = await _payLaterRepository.getDetailPaylater();
    if (response.status == StatusResponse.success) {
      detailPaylater = response.result;
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
      Get.back();
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Error',
              desc: response.message,
              titleTextStyle: text16BlackSemiBold,
              descTextStyle: text12BlackRegular,
              btnCancelOnPress: () {})
          .show();
    }
  }

  toChoicePayment() {
    Get.toNamed(Routes.CHOICE_PAYMENT_PAYLATER,
        arguments: [detailPaylater?.bill?.id, detailPaylater?.bill?.amount]);
  }

  @override
  void onInit() {
    getDetailPaylater();
    super.onInit();
  }
}
