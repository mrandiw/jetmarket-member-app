import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/status_response.dart';

class PengajuanProsesPinjamanController extends GetxController {
  final LoanRepository _loanRepository;
  PengajuanProsesPinjamanController(this._loanRepository);
  void confirmationCancel() {
    AppDialogConfirmation.show(
        title: 'Batalkan Pengajuan',
        message: 'Yakin ingin membatalkan pengajuan pinjaman?',
        onTesText: 'batalkan',
        onPressed: () => cancelLoan());
  }

  Future<void> cancelLoan() async {
    Get.back();
    final response = await _loanRepository.loanCancel(Get.arguments);
    if (response.status == StatusResponse.success) {
      Get.offNamed(Routes.DETAIL_PENGAJUAN_PINJAMAN,
          arguments: response.result?.id);
    }
  }
}
