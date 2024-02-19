import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/error_page.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/detail_payment_paylater.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';

class DetailPaymentPaylaterScreen
    extends GetView<DetailPaymentPaylaterController> {
  const DetailPaymentPaylaterScreen({super.key});
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
        appBar: appBarPaylaterPayment(controller),
        body: const SafeArea(
          child: DetailSection(),
        ),
        bottomNavigationBar: ButtonSection(controller: controller),
      ),
    );
  }
}
