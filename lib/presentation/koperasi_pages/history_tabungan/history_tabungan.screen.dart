import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/history_tabungan.controller.dart';

class HistoryTabunganScreen extends GetView<HistoryTabunganController> {
  const HistoryTabunganScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryTabunganScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HistoryTabunganScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
