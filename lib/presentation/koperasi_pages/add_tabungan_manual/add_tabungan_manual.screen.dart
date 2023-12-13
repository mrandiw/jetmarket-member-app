import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/add_tabungan_manual.controller.dart';

class AddTabunganManualScreen extends GetView<AddTabunganManualController> {
  const AddTabunganManualScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTabunganManualScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTabunganManualScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
