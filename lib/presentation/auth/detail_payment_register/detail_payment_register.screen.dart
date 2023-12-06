import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
