import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/list_chat_model.dart';
import 'package:jetmarket/presentation/chat_pages/chats/section/app_bar_section.dart';
import 'package:jetmarket/presentation/chat_pages/chats/widget/chat_item.dart';

import '../../../components/infiniti_page/infiniti_page.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/chats.controller.dart';

class ChatsScreen extends GetView<ChatsController> {
  const ChatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: CustomScrollView(
        slivers: [
          const AppBarChats(),
          PagedSliverList.separated(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<ListChatModel>(
                itemBuilder: (context, item, index) => ChatItem(
                  data: item,
                ),
                newPageProgressIndicatorBuilder: InfinitiPage.progress,
                firstPageProgressIndicatorBuilder: InfinitiPage.progress,
                noItemsFoundIndicatorBuilder: (_) =>
                    InfinitiPage.empty(_, 'Chat'),
                firstPageErrorIndicatorBuilder: InfinitiPage.error,
              ),
              separatorBuilder: (_, i) => Gap(8.h))
        ],
      ),
    );
  }
}
