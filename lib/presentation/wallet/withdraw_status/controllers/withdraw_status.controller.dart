import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';
import 'package:jetmarket/utils/network/action_status.dart';

import '../../../../domain/core/interfaces/ewallet_repository.dart';
import '../../../../utils/network/status_response.dart';
import '../../e_wallet/controllers/e_wallet.controller.dart';

enum StatusWithdraw { initialize, waiting, calcel }

class WithdrawStatusController extends GetxController {
  final EwalletRepository _ewalletRepository;

  WithdrawStatusController(this._ewalletRepository);

  var status = StatusWithdraw.waiting.obs;
  var actionStatus = ActionStatus.initalize.obs;

  void cancelWithdrawConfirmation() {
    AppDialogConfirmation.show(
        title: 'Batalkan Withdraw?',
        message: 'Penarikan dana akan dibatalkan',
        onTesText: 'Batalkan',
        onPressed: () => cancelWithdraw());
  }

  Future<void> cancelWithdraw() async {
    Get.back();
    actionStatus(ActionStatus.loading);
    final response = await _ewalletRepository.cancelWithdraw(Get.arguments);
    if (response.status == StatusResponse.success) {
      actionStatus(ActionStatus.success);
      status(StatusWithdraw.calcel);
    } else {
      actionStatus(ActionStatus.failed);
    }
  }

  void refreshEwalletPage() {
    Get.back();
    final controller = Get.find<EWalletController>();
    controller.getBalance();
    controller.pagingController.itemList?.clear();
    controller.getBalanceHistory(1);
  }
}
