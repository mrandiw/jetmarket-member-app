import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/ajukan_pinjaman.controller.dart';

class AjukanPinjamanScreen extends GetView<AjukanPinjamanController> {
  const AjukanPinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AjukanPinjamanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AjukanPinjamanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
