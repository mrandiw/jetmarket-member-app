import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/chat_model.dart';
import 'package:jetmarket/domain/core/model/params/chat/pinned_chat.dart';
import 'package:jetmarket/presentation/detail_chat/controllers/detail_chat.controller.dart';
import 'package:jetmarket/presentation/detail_chat/widget/item_chat.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../components/infiniti_page/infiniti_page.dart';
import '../../../utils/app_preference/app_preferences.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({super.key, required this.controller});

  final DetailChatController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(bottom: 72.hr, top: 16.hr),
        sliver: PagedSliverList.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<ChatModel>(
              itemBuilder: (context, item, index) {
                bool isSender =
                    item.fromId == AppPreference().getUserData()?.user?.id;
                bool isReplySender = item.pinnedMessage?.id ==
                    AppPreference().getUserData()?.user?.id;

                return ItemChat(
                  data: item,
                  controller: controller,
                  isSender: isSender,
                  isReplySender: isReplySender,
                  index: index,
                  onHorizontalDragStart: (detail) {
                    var pinnedMessage = PinnedChat(
                        id: item.fromId ?? 0,
                        message: item.text ?? '',
                        isSender: isSender);
                    controller.slidePinChat(
                        detail, index, isSender, pinnedMessage);
                  },
                  onLongPress: () => controller.selectedChatDelet(index),
                  onTapCancel: () => controller.selectedCancelChatDelet(),
                );
              },
              newPageProgressIndicatorBuilder: InfinitiPage.progress,
              firstPageProgressIndicatorBuilder: InfinitiPage.progress,
              noItemsFoundIndicatorBuilder: (_) =>
                  InfinitiPage.empty(_, 'Riwayat'),
              firstPageErrorIndicatorBuilder: InfinitiPage.error,
            ),
            separatorBuilder: (_, i) => Gap(12.h)));
  }
}
