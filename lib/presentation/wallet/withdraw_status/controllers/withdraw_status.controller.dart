import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';
import 'package:jetmarket/utils/network/action_status.dart';

enum StatusWithdraw { initialize, waiting, calcel }

class WithdrawStatusController extends GetxController {
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
    await Future.delayed(3.seconds, () {
      actionStatus(ActionStatus.success);
      status(StatusWithdraw.calcel);
    });
  }
}
