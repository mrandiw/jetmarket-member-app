import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/edit_account/section/app_bar_section.dart';

import 'controllers/edit_account.controller.dart';
import 'section/button_section.dart';
import 'section/form_section.dart';

class EditAccountScreen extends GetView<EditAccountController> {
  const EditAccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: appBarEditAccount,
      body: const FormSection(),
      bottomNavigationBar: ButtonSection(
        controller: controller,
      ),
    );
  }
}
