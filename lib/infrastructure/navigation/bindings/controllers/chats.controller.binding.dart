import 'package:get/get.dart';

import '../../../../presentation/chats/controllers/chats.controller.dart';

class ChatsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsController>(
      () => ChatsController(),
    );
  }
}
