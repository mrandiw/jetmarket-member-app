import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_payment_customer.controller.dart';

class DetailPaymentCustomerScreen
    extends GetView<DetailPaymentCustomerController> {
  const DetailPaymentCustomerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPaymentCustomerScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPaymentCustomerScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
