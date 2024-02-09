import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/error_page.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/choice_payment_paylater.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/payment_section.dart';

class ChoicePaymentPaylaterScreen
    extends GetView<ChoicePaymentPaylaterController> {
  const ChoicePaymentPaylaterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onError: const ErrorPage(),
        onSuccess: successWidget(),
        status: controller.screenStatus.value));
  }

  Widget successWidget() {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: appBarChoicePaymentPaylater,
      body: const PaymentSection(),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
