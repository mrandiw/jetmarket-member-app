import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/set_refund.controller.dart';

class SetRefundScreen extends GetView<SetRefundController> {
  const SetRefundScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetRefundScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SetRefundScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
