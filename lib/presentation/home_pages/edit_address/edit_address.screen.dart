import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/edit_address.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';
import 'section/header_section.dart';
import 'section/list_address_section.dart';

class EditAddressScreen extends GetView<EditAddressController> {
  const EditAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: CustomScrollView(
          slivers: [
            const AppBarEditAddress(),
            const HeaderSection(),
            ListAddressSection(controller: controller)
          ],
        ),
        bottomNavigationBar: const FooterSection());
  }
}
