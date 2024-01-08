import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/choice_payment/section/app_bar_section.dart';
import 'package:jetmarket/presentation/home_pages/choice_payment/section/payment_methode_section.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/choice_payment.controller.dart';
import 'section/button_section.dart';

class ChoicePaymentScreen extends GetView<ChoicePaymentController> {
  const ChoicePaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onSuccess: _successWidget(),
        status: controller.screenStatus.value));
  }

  Widget _successWidget() => Scaffold(
        backgroundColor: kWhite,
        appBar: appBarChoicePayment,
        body: const SafeArea(child: PaymentMethodeSection()),
        bottomNavigationBar: const ButtonSection(),
      );
}
