import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/change_password.controller.dart';
import 'section/app_bar_section.dart';
import 'section/form_section.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: appBarChangePassword,
        body: const FormSection());
  }
}
