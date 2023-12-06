import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/checkout_payment.controller.dart';

class CheckoutPaymentScreen extends GetView<CheckoutPaymentController> {
  const CheckoutPaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckoutPaymentScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckoutPaymentScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
