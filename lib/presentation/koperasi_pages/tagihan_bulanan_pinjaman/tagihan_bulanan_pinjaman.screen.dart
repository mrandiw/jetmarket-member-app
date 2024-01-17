import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tagihan_bulanan_pinjaman.controller.dart';

class TagihanBulananPinjamanScreen
    extends GetView<TagihanBulananPinjamanController> {
  const TagihanBulananPinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TagihanBulananPinjamanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TagihanBulananPinjamanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
