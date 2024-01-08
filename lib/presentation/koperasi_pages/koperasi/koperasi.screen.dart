import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/koperasi.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';
import 'section/history_section.dart';

class KoperasiScreen extends GetView<KoperasiController> {
  const KoperasiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarKoperasi,
      backgroundColor: kWhite,
      // body: ListView(
      //   children: [
      //     HeaderSection(controller: controller),
      //     const HistorySection()
      //   ],
      // )
    );
  }
}
