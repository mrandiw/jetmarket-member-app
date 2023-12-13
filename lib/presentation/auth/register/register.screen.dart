import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import 'controllers/register.controller.dart';
import 'section/form_section.dart';
import 'section/header_section.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SizedBox(
          height: Get.height.hr,
          width: Get.width.wr,
          child: const Stack(
            clipBehavior: Clip.none,
            children: [
              HeaderSection(),
              FormSection(),
            ],
          ),
        ),
      ),
    );
  }
}
