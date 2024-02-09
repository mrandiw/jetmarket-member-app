import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/notification/controllers/notification.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

class AppBarNotification extends StatelessWidget {
  const AppBarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: kWhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(arrowForward),
      ),
      title: Text('Notifikasi', style: text16BlackSemiBold),
      actions: [
        GetBuilder<NotificationController>(builder: (controller) {
          return Badge.count(
              count: controller.unreadChat,
              backgroundColor: kPrimaryColor,
              largeSize: 14,
              textStyle: TextStyle(fontSize: 8.sp, color: kWhite),
              isLabelVisible: controller.unreadChat > 0 ? true : false,
              offset: const Offset(-10, 10),
              child: IconButton(
                  onPressed: () => Get.toNamed(Routes.CHATS),
                  icon: SvgPicture.asset(chatFill)));
        })
      ],
    );
  }
}
