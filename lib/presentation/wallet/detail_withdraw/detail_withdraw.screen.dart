import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_withdraw.controller.dart';

class DetailWithdrawScreen extends GetView<DetailWithdrawController> {
  const DetailWithdrawScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailWithdrawScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailWithdrawScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
