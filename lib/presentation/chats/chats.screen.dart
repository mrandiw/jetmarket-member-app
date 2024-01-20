import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/chats.controller.dart';

class ChatsScreen extends GetView<ChatsController> {
  const ChatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatsScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatsScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
