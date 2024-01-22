import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/controllers/detail_chat.controller.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/widget/item_chat.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../components/infiniti_page/infiniti_page.dart';
import '../../../../utils/app_preference/app_preferences.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({super.key, required this.controller});

  final DetailChatController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(bottom: 72.hr, top: 16.hr),
        sliver: PagedSliverList(pagingController: controller.pagingController, builderDelegate: builderDelegate)
        // sliver: PagedSliverList.separated(
        //     pagingController: controller.pagingController,
        //     builderDelegate: PagedChildBuilderDelegate<ChatModel>(
        //       itemBuilder: (context, item, index) {
        //         bool isSender =
        //             item.sender?.role == controller.dataArgument?.fromRole;
        //         bool isReplySender = item.pinnedMessage?.role ==
        //             controller.dataArgument?.fromRole;
        //         return ItemChat(
        //           data: item,
        //           controller: controller,
        //           isSender: isSender,
        //           isReplySender: isReplySender,
        //           index: index,
        //           onHorizontalDragStart: (detail) {
        //             var pinnedMessage = PinnedMessage(
        //                 senderId: item.sender?.id,
        //                 receiverId: item.receiver?.id,
        //                 text: item.text,
        //                 senderName: AppPreference().getUserData()?.user?.name,
        //                 receiverName: controller.dataArgument?.name,
        //                 isSender: isSender,
        //                 role: item.sender?.role);
        //             controller.slidePinChat(
        //                 detail, index, isSender, pinnedMessage);
        //           },
        //           onLongPress: () => controller.selectedChatDelet(item),
        //           onTapCancel: () => controller.selectedCancelChatDelet(item),
        //         );
        //       },
        //       newPageProgressIndicatorBuilder: InfinitiPage.progress,
        //       firstPageProgressIndicatorBuilder: InfinitiPage.progress,
        //       noItemsFoundIndicatorBuilder: (_) =>
        //           InfinitiPage.empty(_, 'Riwayat'),
        //       firstPageErrorIndicatorBuilder: InfinitiPage.error,
        //     ),
            separatorBuilder: (_, i) => Gap(12.h))
            )
  }
}
