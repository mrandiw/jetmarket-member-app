import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tracking_return_order.controller.dart';

class TrackingReturnOrderScreen extends GetView<TrackingReturnOrderController> {
  const TrackingReturnOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackingReturnOrderScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TrackingReturnOrderScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
