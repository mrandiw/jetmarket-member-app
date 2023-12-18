import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/withdraw/section/app_bar_section.dart';

import 'controllers/withdraw.controller.dart';
import 'section/form_section.dart';

class WithdrawScreen extends GetView<WithdrawController> {
  const WithdrawScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithdraw, body: FormSection(controller: controller));
  }
}
