import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/detail_address.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';
import 'section/form_section.dart';

class DetailAddressScreen extends GetView<DetailAddressController> {
  const DetailAddressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: appBarDetailAddress,
      body: ListView(
        children: const [FormSection()],
      ),
      bottomNavigationBar: FooterSection(
        controller: controller,
      ),
    );
  }
}
