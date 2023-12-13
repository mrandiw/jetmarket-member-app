import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tabungan.controller.dart';

class TabunganScreen extends GetView<TabunganController> {
  const TabunganScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabunganScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TabunganScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
