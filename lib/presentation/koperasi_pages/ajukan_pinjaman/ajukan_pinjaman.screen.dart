import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/ajukan_pinjaman.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/form_section.dart';

class AjukanPinjamanScreen extends GetView<AjukanPinjamanController> {
  const AjukanPinjamanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAjukanPinjaman,
      body: const FormSection(),
      bottomNavigationBar: const ButtonSection(),
    );
  }
}
