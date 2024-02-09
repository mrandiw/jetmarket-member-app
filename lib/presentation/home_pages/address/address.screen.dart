import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/address.controller.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddressScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddressScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
