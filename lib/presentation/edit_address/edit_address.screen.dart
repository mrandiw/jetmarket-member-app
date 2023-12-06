import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/edit_address.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';
import 'section/list_address_section.dart';

class EditAddressScreen extends GetView<EditAddressController> {
  const EditAddressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarEditAddress,
        body: ListView(
          children: const [HeaderSection(), ListAddressSection()],
        ));
  }
}
