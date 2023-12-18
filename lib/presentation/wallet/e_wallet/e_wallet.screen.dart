import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/e_wallet.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';
import 'section/history_section.dart';

class EWalletScreen extends GetView<EWalletController> {
  const EWalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarEwallet,
        backgroundColor: kWhite,
        body: ListView(
          children: [
            HeaderSection(controller: controller),
            const HistorySection()
          ],
        ));
  }
}
