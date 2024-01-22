import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/chat_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/file_repository_impl.dart';

import '../../../../presentation/chat_pages/detail_chat/controllers/detail_chat.controller.dart';

class DetailChatControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailChatController>(
      () => DetailChatController(FileRepositoryImpl(), ChatRepositoryImpl()),
    );
  }
}
