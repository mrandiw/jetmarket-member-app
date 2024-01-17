import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/pinjaman/section/choice_loan.dart';

import 'controllers/pinjaman.controller.dart';
import 'section/app_bar_section.dart';

class PinjamanScreen extends GetView<PinjamanController> {
  const PinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPinjaman,
      body: ChoiceLoanSection(controller: controller),
    );
  }
}
