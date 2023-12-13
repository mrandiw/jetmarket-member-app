import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/payment_tabungan_success.controller.dart';

class PaymentTabunganSuccessScreen
    extends GetView<PaymentTabunganSuccessController> {
  const PaymentTabunganSuccessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentTabunganSuccessScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentTabunganSuccessScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
