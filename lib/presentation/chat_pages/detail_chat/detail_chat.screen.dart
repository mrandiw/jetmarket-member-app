import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/section/message_section.dart';
import 'controllers/detail_chat.controller.dart';
import 'section/app_bar_section.dart';
import 'section/chat_section.dart';

class DetailChatScreen extends GetView<DetailChatController> {
  const DetailChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarDetailChat(),
        body: Stack(
          children: [
            // CustomScrollView(
            //   controller: controller.scrollController,
            //   slivers: [ChatSection(controller: controller)],
            // ),
            GetBuilder<DetailChatController>(builder: (controller) {
              return ChatSection(
                controller: controller,
                scrollController: controller.scrollController,
                reverse: controller.isReverse,
              );
            }),

            // Obx(() {
            //   if (controller.isCurrnetPositionOnTop.value) {
            //     return ChatSection(
            //       controller: controller,
            //       scrollController: controller.scrollController,
            //     );
            //   } else {
            //     return ChatFromStore(
            //       controller: controller,
            //       scrollController: controller.scrollController,
            //     );
            //   }
            // }),
            MessageSection(controller: controller),
          ],
        ));
  }
}
