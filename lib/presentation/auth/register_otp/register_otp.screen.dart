import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import 'controllers/register_otp.controller.dart';
import 'section/form_section.dart';
import 'section/header_section.dart';

class RegisterOtpScreen extends GetView<RegisterOtpController> {
  const RegisterOtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Container(
        color: kWhite,
        height: Get.height.hr,
        width: Get.width.wr,
        child: const Stack(
          clipBehavior: Clip.none,
          children: [
            HeaderSection(),
            FormSection(),
            // Positioned(top: 46.r, left: 16.r, child: AppBackButton.circle())
          ],
        ),
      ),
    );
  }
}
