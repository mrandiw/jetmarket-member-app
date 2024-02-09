import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/checkout_payment.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';

class CheckoutPaymentScreen extends GetView<CheckoutPaymentController> {
  const CheckoutPaymentScreen({super.key});
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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.backtoMerchent();
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: appBarPaymentOrder,
        body: const SafeArea(
          child: DetailSection(),
        ),
        bottomNavigationBar: ButtonSection(controller: controller),
      ),
    );
  }
}
