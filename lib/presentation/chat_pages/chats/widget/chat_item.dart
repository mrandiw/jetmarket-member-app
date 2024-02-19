import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/list_chat_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/extension/time_ago.dart';
import '../../../../domain/core/model/argument/chat_room_argument.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.data});

  final ListChatModel data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ChatRoomArgument? dataArgument;
        dataArgument = ChatRoomArgument(
          chatId: data.id,
          toId: data.id,
          fromRole: 'customer',
          toRole: '',
          image: data.image,
          name: data.name,
          createdAt: data.createdAt,
          unreadCount: data.unreadCount,
        );
        Get.toNamed(Routes.DETAIL_CHAT, arguments: dataArgument);
      },
      contentPadding: EdgeInsets.symmetric(vertical: 4.hr, horizontal: 16.wr),
      tileColor: data.unreadCount == 0 ? kWhite : kPrimaryColor2,
      leading: CachedNetworkImage(
          imageUrl: data.image ?? '',
          imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 16.r,
                backgroundColor: kPrimaryColor2,
                backgroundImage: imageProvider,
              ),
          placeholder: (context, url) => SizedBox(
                height: 16.r,
                width: 16.r,
                child: const Center(
                  child: CupertinoActivityIndicator(color: kSoftBlack),
                ),
              ),
          errorWidget: (context, url, error) => CircleAvatar(
                radius: 16.r,
                backgroundColor: kPrimaryColor2,
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: kPrimaryColor,
                    size: 20.r,
                  ),
                ),
              )),
      title: Text(data.name ?? '', style: text14BlackMedium),
      subtitle: Text(data.message ?? '', style: text12HintRegular),
      trailing: SizedBox(
        width: 100.wr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(data.updatedAt?.timeAgo() ?? '', style: text12HintRegular),
            Gap(8.hr),
            Visibility(
              visible: data.unreadCount! > 0,
              child: CircleAvatar(
                radius: 8.r,
                backgroundColor: kPrimaryColor,
                child: Text(data.unreadCount.toString(),
                    style: text10WhiteRegular),
              ),
            )
          ],
        ),
      ),
    );
  }
}
