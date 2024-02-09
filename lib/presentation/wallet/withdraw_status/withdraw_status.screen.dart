import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/wallet/withdraw_status/section/cancel_withdraw.dart';
import 'package:jetmarket/presentation/wallet/withdraw_status/section/waiting_approve.dart';

import 'controllers/withdraw_status.controller.dart';
import 'section/app_bar_section.dart';

class WithdrawStatusScreen extends GetView<WithdrawStatusController> {
  const WithdrawStatusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.refreshEwalletPage();
      },
      child: Scaffold(
          appBar: appBarWithdraw(controller),
          backgroundColor: kWhite,
          body: Obx(() => controller.status.value == StatusWithdraw.waiting
              ? WaitingApprove(controller: controller)
              : CancelWithdraw(
                  controller: controller,
                ))),
    );
  }
}
