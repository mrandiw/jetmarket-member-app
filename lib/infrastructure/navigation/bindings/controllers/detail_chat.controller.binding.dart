import 'package:get/get.dart';

import '../../../../presentation/detail_chat/controllers/detail_chat.controller.dart';

class DetailChatControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailChatController>(
      () => DetailChatController(),
    );
  }
}
