import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/model/params/notification/notification_param.dart';

import '../../../domain/core/interfaces/notification_repository.dart';
import '../../../domain/core/model/argument/chat_room_argument.dart';
import '../../../domain/core/model/model_data/notification.dart';
import '../../../infrastructure/dal/repository/notification_repository_impl.dart';
import '../../../infrastructure/dal/services/firebase/firebase_controller.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/network/status_response.dart';

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepository;
  final ChatRepository _chatRepository;
  NotificationController(this._notificationRepository, this._chatRepository);
  static const _pageSize = 10;

  PagingController<int, NotificationData> pagingController =
      PagingController(firstPageKey: 1);

  int unreadChat = 0;

  Future<void> getNotification(int pageKey) async {
    try {
      var param = NotificationParam(page: pageKey, size: _pageSize);
      final response = await _notificationRepository.getNotification(param);
      if (pageKey == 1) {
        await updateUnreadNotification();
      }
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

  Future<void> getUnreadChat() async {
    final response = await _chatRepository.getUnreadChat();
    if (response.status == StatusResponse.success) {
      unreadChat = response.result!;
      update();
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {});
  }

  void onTapNotification(NotificationData notification) {
    var data = dataPagelink(notification.pagelink);
    switch (data?.path) {
      case 'chat':
        Get.toNamed(Routes.DETAIL_CHAT,
            arguments: ChatRoomArgument(
              chatId: data?.pathId,
              fromRole: 'customer',
            ));
      case 'order':
        Get.toNamed(Routes.DETAIL_ORDER,
            arguments: [data?.pathId, null, null, data?.refId]);
      case 'withdraw':
        Get.toNamed(Routes.DETAIL_WITHDRAW, arguments: [data?.refId, null]);
      case 'topup':
        Get.toNamed(Routes.DETAIL_TOPUP, arguments: [data?.refId, null]);
      case 'loan-propose':
        Get.toNamed(Routes.DETAIL_PENGAJUAN_PINJAMAN,
            arguments: [data?.pathId, null]);
      case 'loan-bill':
        Get.toNamed(Routes.DETAIL_TAGIHAN_BULANAN,
            arguments: [data?.pathId, null]);
      case 'saving':
        Get.toNamed(Routes.DETAIL_MENABUNG, arguments: [data?.pathId, null]);
      case 'referral':
        Get.toNamed(Routes.REFERRAL);
      case 'transaction':
        Get.toNamed(Routes.ORDER_LIST_TRANSACTION,
            arguments: [data?.refId, null]);
      default:
        break;
    }
  }

  Future<void> updateUnreadNotification() async {
    final controller =
        Get.put(FirebaseController(NotificationRepositoryImpl()));
    await controller.getUnreadNotification();
  }

  NotificationData? dataPagelink(String? pagelink) {
    if (pagelink != null) {
      List<String> parts = pagelink.split('/');
      parts.removeAt(0);
      if (parts[0] == 'withdraw' ||
          parts[0] == 'topup' ||
          parts[0] == 'transaction') {
        return NotificationData(path: parts[0], refId: parts[1]);
      } else if (parts[0] == 'loan') {
        return NotificationData(
            path: "${parts[0]}-${parts[1]}", pathId: int.parse(parts[2]));
      } else if (parts[0] == 'order') {
        String value = parts[1];
        if (value.startsWith('ORD#')) {
          return NotificationData(path: parts[0], refId: parts[1]);
        } else {
          return NotificationData(path: parts[0], pathId: int.parse(parts[1]));
        }
      } else {
        return NotificationData(path: parts[0], pathId: int.parse(parts[1]));
      }
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    getUnreadChat();
    pagingController.addPageRequestListener((page) {
      print("terpanggil");
      getNotification(page);
    });

    super.onInit();
  }
}
