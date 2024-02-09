import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_checkout.controller.dart';

class DetailCheckoutScreen extends GetView<DetailCheckoutController> {
  const DetailCheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailCheckoutScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailCheckoutScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
