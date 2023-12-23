import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/add_address.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';
import 'section/list_address.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  const AddAddressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: appBarAddAddress,
        body: ListView(
          children: const [HeaderSection(), ListAddress()],
        ));
  }
}
