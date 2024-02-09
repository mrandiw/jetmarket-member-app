import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan_manual/section/nominal_saldo_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/add_tabungan_manual.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/payment_methode_section.dart';

class AddTabunganManualScreen extends GetView<AddTabunganManualController> {
  const AddTabunganManualScreen({super.key});
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

  Scaffold successWidget(AddTabunganManualController controller) {
    return Scaffold(
      appBar: appBarAddTabunganManual,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: const [NominalSaldoSection(), PaymentMethodeSection()],
      ),
      bottomNavigationBar: const ButtonSection(),
    );
  }
}
