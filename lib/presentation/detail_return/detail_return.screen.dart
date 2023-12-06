import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_return.controller.dart';

class DetailReturnScreen extends GetView<DetailReturnController> {
  const DetailReturnScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailReturnScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailReturnScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
