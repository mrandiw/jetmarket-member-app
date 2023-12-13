import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_menabung.controller.dart';

class DetailMenabungScreen extends GetView<DetailMenabungController> {
  const DetailMenabungScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailMenabungScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailMenabungScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
