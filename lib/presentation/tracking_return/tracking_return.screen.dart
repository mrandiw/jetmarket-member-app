import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tracking_return.controller.dart';

class TrackingReturnScreen extends GetView<TrackingReturnController> {
  const TrackingReturnScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackingReturnScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TrackingReturnScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
