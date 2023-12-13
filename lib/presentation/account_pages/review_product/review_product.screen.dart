import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/review_product.controller.dart';

class ReviewProductScreen extends GetView<ReviewProductController> {
  const ReviewProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReviewProductScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReviewProductScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
