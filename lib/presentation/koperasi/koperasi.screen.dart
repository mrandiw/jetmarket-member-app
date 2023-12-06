import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/koperasi.controller.dart';

class KoperasiScreen extends GetView<KoperasiController> {
  const KoperasiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KoperasiScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KoperasiScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
