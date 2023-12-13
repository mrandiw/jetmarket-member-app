import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/all_category.controller.dart';

class AllCategoryScreen extends GetView<AllCategoryController> {
  const AllCategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllCategoryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AllCategoryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
