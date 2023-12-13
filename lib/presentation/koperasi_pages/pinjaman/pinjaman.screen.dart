import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/pinjaman.controller.dart';

class PinjamanScreen extends GetView<PinjamanController> {
  const PinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PinjamanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PinjamanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
