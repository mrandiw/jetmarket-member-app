import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tabungan_payment.controller.dart';

class TabunganPaymentScreen extends GetView<TabunganPaymentController> {
  const TabunganPaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabunganPaymentScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TabunganPaymentScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
