import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/controllers/detail_chat.controller.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/widget/item_chat.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/widget/time_widget.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';
import '../../../../utils/app_preference/app_preferences.dart';

class ChatSection extends StatelessWidget {
  const ChatSection(
      {super.key, required this.controller, this.scrollController});

  final DetailChatController controller;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
        scrollController: scrollController,
        padding: EdgeInsets.only(bottom: 16, top: 16.hr),
        pagingController: controller.pagingController,
        dragStartBehavior: DragStartBehavior.start,
        builderDelegate: PagedChildBuilderDelegate<ChatModel>(
          itemBuilder: (context, item, index) {
            bool isSender =
                item.sender?.role == controller.dataArgument?.fromRole;
            bool isReplySender =
                item.pinnedMessage?.role == controller.dataArgument?.fromRole;

            bool isSameDate = false;
            String? newDate = '';

            if (index == 0 &&
                controller.pagingController.itemList?.length == 1) {
              newDate = controller
                  .groupMessageDateAndTime(
                      item.createdAt?.formatCreatedAt ?? '')
                  .toString();
            } else if (index ==
                (controller.pagingController.itemList?.length ?? 0) - 1) {
              newDate = controller
                  .groupMessageDateAndTime(
                      item.createdAt?.formatCreatedAt ?? '')
                  .toString();
            } else {
              final DateTime date = controller.returnDateAndTimeFormat(
                  item.createdAt?.formatCreatedAt ?? '');
              final DateTime prevDate = controller.returnDateAndTimeFormat(
                  controller.pagingController.itemList?[index + 1].createdAt
                          ?.formatCreatedAt ??
                      '');
              isSameDate = date.isAtSameMomentAs(prevDate);

              newDate = isSameDate
                  ? ''
                  : controller
                      .groupMessageDateAndTime(controller.pagingController
                              .itemList?[index].createdAt?.formatCreatedAt ??
                          '')
                      .toString();
            }

            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == 0
                      ? paddingBottom(
                          controller.pagingController.itemList?.length ?? 0)
                      : 0),
              child: ItemChat(
                data: item,
                isSender: isSender,
                isReplySender: isReplySender,
                index: index,
                controller: controller,
                onHorizontalDragStart: (detail) {
                  var pinnedMessage = PinnedMessage(
                      id: item.id,
                      senderId: item.sender?.id,
                      receiverId: item.receiver?.id,
                      text: item.text,
                      senderName: AppPreference().getUserData()?.user?.name,
                      receiverName: controller.dataArgument?.name,
                      isSender: isSender,
                      role: item.sender?.role);
                  controller.slidePinChat(
                      detail, index, isSender, pinnedMessage);
                },
                onLongPress: () => controller.selectedChatDelet(item),
                onTapCancel: () => controller.selectedCancelChatDelet(item),
                timeWidget: newDate.isNotEmpty
                    ? TimeWidget(createdAtString: newDate)
                    : const SizedBox.shrink(),
              ),
            );
          },
          newPageProgressIndicatorBuilder: InfinitiPage.progress,
          firstPageProgressIndicatorBuilder: InfinitiPage.progress,
          noItemsFoundIndicatorBuilder: (_) => InfinitiPage.empty(_, 'Riwayat'),
          firstPageErrorIndicatorBuilder: InfinitiPage.error,
        ),
        reverse: true,
        separatorBuilder: (_, i) => Gap(12.h));
  }

  double paddingBottom(int length) {
    if (length == 1) {
      return 530.hr;
    } else if (length == 2) {
      return 400.hr;
    } else if (length == 3) {
      return 320.hr;
    } else if (length == 4) {
      return 250.hr;
    } else if (length == 5) {
      return 150.hr;
    } else {
      return 72.hr;
    }
  }
}
