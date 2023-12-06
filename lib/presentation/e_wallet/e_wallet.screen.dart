import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/e_wallet.controller.dart';

class EWalletScreen extends GetView<EWalletController> {
  const EWalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EWalletScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EWalletScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
