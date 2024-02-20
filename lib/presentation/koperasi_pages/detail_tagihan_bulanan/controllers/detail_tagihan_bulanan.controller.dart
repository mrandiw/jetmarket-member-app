import 'package:get/get.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../domain/core/model/model_data/detail_loan_bill_model.dart';
import '../../../../infrastructure/dal/repository/notification_repository_impl.dart';
import '../../../../infrastructure/dal/services/firebase/firebase_controller.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../../main_pages/controllers/main_pages.controller.dart';

class DetailTagihanBulananController extends GetxController {
  final LoanRepository _loanRepository;
  DetailTagihanBulananController(this._loanRepository);

  DetailLoanBillModel? detailLoan;

  var screenStatus = ScreenStatus.initalize.obs;

  Future<void> getDetailLoan() async {
    screenStatus(ScreenStatus.loading);
    final response = await _loanRepository.getDetailLoanBill(Get.arguments[0]);
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
      updateUnreadNotification();
      Get.offAllNamed(Routes.MAIN_PAGES);
      Get.put(MainPagesController());
    } else {
      Get.back();
    }
  }

  Future<void> updateUnreadNotification() async {
    final controller =
        Get.put(FirebaseController(NotificationRepositoryImpl()));
    await controller.getUnreadNotification();
  }

  @override
  void onInit() {
    getDetailLoan();
    super.onInit();
  }
}
