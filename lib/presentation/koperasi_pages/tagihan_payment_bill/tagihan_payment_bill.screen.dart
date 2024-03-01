// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/tagihan_payment_bill.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';

class TagihanPaymentBillScreen extends GetView<TagihanPaymentBillController> {
  const TagihanPaymentBillScreen({super.key});
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
    return WillPopScope(
      onWillPop: () async {
        controller.toMain();
        return false;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: appBarBillPayment,
        body: const SafeArea(
          child: DetailSection(),
        ),
        bottomNavigationBar: ButtonSection(controller: controller),
      ),
    );
  }
}
