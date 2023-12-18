import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/wallet/withdraw_status/section/cancel_withdraw.dart';
import 'package:jetmarket/presentation/wallet/withdraw_status/section/waiting_approve.dart';

import 'controllers/withdraw_status.controller.dart';
import 'section/app_bar_section.dart';

class WithdrawStatusScreen extends GetView<WithdrawStatusController> {
  const WithdrawStatusScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithdraw,
        backgroundColor: kWhite,
        body: Obx(() => controller.status.value == StatusWithdraw.waiting
            ? WaitingApprove(controller: controller)
            : CancelWithdraw(
                controller: controller,
              )));
  }
}
