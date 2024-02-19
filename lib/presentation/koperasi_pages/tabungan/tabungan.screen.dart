import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tabungan.controller.dart';
import 'section/app_bar_section.dart';
import 'section/choice_option.dart';

class TabunganScreen extends GetView<TabunganController> {
  const TabunganScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return successWidget(controller);
  }

  Scaffold successWidget(TabunganController controller) {
    return Scaffold(
      appBar: appBarTabungan,
      body: ListView(
        children: const [
          ChoiceOption(),
        ],
      ),
    );
  }
}
