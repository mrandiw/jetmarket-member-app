import 'package:get/get.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../domain/core/model/model_data/detail_loan_bill_model.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class DetailTagihanBulananController extends GetxController {
  final LoanRepository _loanRepository;
  DetailTagihanBulananController(this._loanRepository);

  DetailLoanBillModel? detailLoan;

  var screenStatus = ScreenStatus.initalize.obs;

  Future<void> getDetailLoan() async {
    screenStatus(ScreenStatus.loading);
    final response = await _loanRepository.getDetailLoanBill(Get.arguments);
    if (response.status == StatusResponse.success) {
      detailLoan = response.result;
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  @override
  void onInit() {
    getDetailLoan();
    super.onInit();
  }
}
