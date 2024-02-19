import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/add_tabungan.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/form_section.dart';

class AddTabunganScreen extends GetView<AddTabunganController> {
  const AddTabunganScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAddTabungan,
      body: const FormSection(),
      bottomNavigationBar: const ButtonSection(),
    );
  }
}
