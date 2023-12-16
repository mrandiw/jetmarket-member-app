import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/params/notification/notification_param.dart';

import '../../../domain/core/interfaces/notification_repository.dart';
import '../../../domain/core/model/model_data/notification.dart';

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepository;
  NotificationController(this._notificationRepository);
  static const _pageSize = 10;

  PagingController<int, NotificationData> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> getNotification(int pageKey) async {
    try {
      var param = NotificationParam(page: pageKey, size: _pageSize);
      final response = await _notificationRepository.getNotification(param);
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

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {});
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getNotification(page);
    });
    super.onInit();
  }
}
