import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/error_page.dart';

import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/payment_register.controller.dart';
import 'section/button_section.dart';
import 'section/payment_section.dart';
import 'section/header_section.dart';

class PaymentRegisterScreen extends GetView<PaymentRegisterController> {
  const PaymentRegisterScreen({Key? key}) : super(key: key);
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
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: const Stack(
          clipBehavior: Clip.none,
          children: [HeaderSection(), PaymentSection()],
        ),
      ),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
