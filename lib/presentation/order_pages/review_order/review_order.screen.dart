import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/review_order.controller.dart';

class ReviewOrderScreen extends GetView<ReviewOrderController> {
  const ReviewOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReviewOrderScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReviewOrderScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
