import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/payment_payletter/section/app_bar_section.dart';
import 'package:jetmarket/presentation/home_pages/payment_payletter/section/list_payleter.dart';
import 'package:jetmarket/presentation/home_pages/payment_payletter/section/sk_approve_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/payment_payletter.controller.dart';
import 'section/button_section.dart';

class PaymentPayletterScreen extends GetView<PaymentPayletterController> {
  const PaymentPayletterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onSuccess: _successWidget(),
        status: controller.screenStatus.value));
  }

  Scaffold _successWidget() {
    return Scaffold(
      appBar: appBarPaymentPayleter,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: [
          const ListPayletterSection(),
          SkApproveSection(controller: controller)
        ],
      ),
      bottomNavigationBar: const ButtonSection(),
    );
  }
}
