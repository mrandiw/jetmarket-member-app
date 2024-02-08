import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/tabungan_payment.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';

class TabunganPaymentScreen extends GetView<TabunganPaymentController> {
  const TabunganPaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Widget successWidget() {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: appBarTabunganPayment,
      body: const SafeArea(
        child: DetailSection(),
      ),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
