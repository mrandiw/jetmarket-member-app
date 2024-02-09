import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/auth/login/section/form_section.dart';
import 'package:jetmarket/presentation/auth/login/section/header_section.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SizedBox(
        height: Get.height.hr,
        width: Get.width.wr,
        child: const Stack(
          clipBehavior: Clip.none,
          children: [HeaderSection(), FormSection()],
        ),
      ),
    );
  }
}
