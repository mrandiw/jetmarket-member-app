import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/add_tabungan.controller.dart';

class AddTabunganScreen extends GetView<AddTabunganController> {
  const AddTabunganScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTabunganScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTabunganScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
