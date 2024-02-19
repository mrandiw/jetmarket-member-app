import 'package:get/get.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../domain/core/model/model_data/loan_entry_cancel_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';

class DetailPengajuanPinjamanController extends GetxController {
  final LoanRepository _loanRepository;

  DetailPengajuanPinjamanController(this._loanRepository);
  DetailLoanModel? detailLoan;

  var screenStatus = ScreenStatus.initalize.obs;

  Future<void> getDetailLoan() async {
    screenStatus(ScreenStatus.loading);
    final response =
        await _loanRepository.getDetailLoanPropose(Get.arguments[0]);
    if (response.status == StatusResponse.success) {
      detailLoan = response.result;
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
    getDetailLoan();
    super.onInit();
  }
}
