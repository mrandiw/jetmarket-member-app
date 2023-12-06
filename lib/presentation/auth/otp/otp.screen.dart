import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/otp.controller.dart';
import 'section/form_section.dart';
import 'section/header_section.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: const Stack(
          clipBehavior: Clip.none,
          children: [HeaderSection(), FormSection()],
        ),
      ),
    );
  }
}
