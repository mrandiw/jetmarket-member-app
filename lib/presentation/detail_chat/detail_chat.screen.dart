import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/detail_chat/section/chat_section.dart';
import 'package:jetmarket/presentation/detail_chat/section/message_section.dart';
import 'controllers/detail_chat.controller.dart';
import 'section/app_bar_section.dart';

class DetailChatScreen extends GetView<DetailChatController> {
  const DetailChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarDetailChat(),
        body: Stack(
          children: [
            CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                ChatSection(controller: controller)
                // TodayChat(controller: controller),
                // ProviousDayChat(controller: controller)
              ],
            ),
            MessageSection(controller: controller),
          ],
        ));
  }
}
