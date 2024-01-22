import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/chat_repository_impl.dart';

import '../../../../presentation/chat_pages/chats/controllers/chats.controller.dart';

class ChatsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsController>(
      () => ChatsController(ChatRepositoryImpl()),
    );
  }
}
