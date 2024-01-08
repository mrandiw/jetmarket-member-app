import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/choice_delivery_refund.controller.dart';

class ChoiceDeliveryRefundScreen
    extends GetView<ChoiceDeliveryRefundController> {
  const ChoiceDeliveryRefundScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChoiceDeliveryRefundScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChoiceDeliveryRefundScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
