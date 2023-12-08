import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/parent_scaffold.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/detail_payment_register.controller.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';
import 'section/header_section.dart';

class DetailPaymentRegisterScreen
    extends GetView<DetailPaymentRegisterController> {
  const DetailPaymentRegisterScreen({Key? key}) : super(key: key);
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

  Scaffold successWidget() {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: const Stack(
            clipBehavior: Clip.none,
            children: [HeaderSection(), DetailSection()],
          ),
        ),
      ),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
