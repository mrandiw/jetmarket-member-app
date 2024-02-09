import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/list_address.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';
import 'section/header_section.dart';
import 'section/list_address_section.dart';

class ListAddressScreen extends GetView<ListAddressController> {
  const ListAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarListAddress,
      backgroundColor: kWhite,
      body: ListView(
        children: const [HeaderSection(), ListAddressSection()],
      ),
      bottomNavigationBar: const FooterSection(),
    );
  }
}
