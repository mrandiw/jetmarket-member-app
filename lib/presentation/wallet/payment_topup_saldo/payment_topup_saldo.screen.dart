import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/payment_topup_saldo.controller.dart';

class PaymentTopupSaldoScreen extends GetView<PaymentTopupSaldoController> {
  const PaymentTopupSaldoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentTopupSaldoScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentTopupSaldoScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
