import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/list_chat_model.dart';

import '../../../../domain/core/interfaces/chat_repository.dart';

class ChatsController extends GetxController {
  final ChatRepository _chatRepository;
  ChatsController(this._chatRepository);

  PagingController<int, ListChatModel> pagingController =
      PagingController(firstPageKey: 1);

  static const _pageSize = 10;

  Future<void> getListChat(int pageKey) async {
    try {
      final response =
          await _chatRepository.getListChat(page: pageKey, size: _pageSize);
      final isLastPage = response.result!.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getListChat(page);
    });
    super.onInit();
  }
}
