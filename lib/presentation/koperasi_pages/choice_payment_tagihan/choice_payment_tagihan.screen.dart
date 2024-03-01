import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/choice_payment_tagihan.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/payment_methode_section.dart';

class ChoicePaymentTagihanScreen
    extends GetView<ChoicePaymentTagihanController> {
  const ChoicePaymentTagihanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(controller),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Scaffold successWidget(ChoicePaymentTagihanController controller) {
    return Scaffold(
      appBar: appBarCPaymentTagihan,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: const [PaymentMethodeSection()],
      ),
      bottomNavigationBar: const ButtonSection(),
    );
  }
}
