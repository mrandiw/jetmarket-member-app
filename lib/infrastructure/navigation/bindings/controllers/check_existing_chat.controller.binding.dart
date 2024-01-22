import 'package:get/get.dart';

import '../../../../presentation/chat_pages/check_existing_chat/controllers/check_existing_chat.controller.dart';
import '../../../dal/repository/chat_repository_impl.dart';

class CheckExistingChatControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      CheckExistingChatController(ChatRepositoryImpl()),
    );
  }
}
