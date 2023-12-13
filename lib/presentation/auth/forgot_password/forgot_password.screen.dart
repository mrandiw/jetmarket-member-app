import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../components/button/back_button.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import 'controllers/forgot_password.controller.dart';
import 'section/form_section.dart';
import 'section/header_section.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const HeaderSection(),
            const FormSection(),
            Positioned(top: 48.r, left: 16.r, child: AppBackButton.circle()),
          ],
        ),
      ),
    );
  }
}
