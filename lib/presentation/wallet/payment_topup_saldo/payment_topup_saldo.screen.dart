import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/app_bar_section.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/error_page.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/payment_topup_saldo.controller.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';

class PaymentTopupSaldoScreen extends GetView<PaymentTopupSaldoController> {
  const PaymentTopupSaldoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onError: const ErrorPage(),
        onSuccess: successWidget(),
        status: controller.screenStatus.value));
  }

  Widget successWidget() {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.refreshEwalletPage();
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: appBarTopUpPayment(controller),
        body: const SafeArea(
          child: DetailSection(),
        ),
        bottomNavigationBar: ButtonSection(controller: controller),
      ),
    );
  }
}
