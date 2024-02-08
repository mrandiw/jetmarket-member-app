import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/services/firebase/firebase_controller.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

AppBar get appBarEwallet {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    toolbarHeight: 52.hr,
    title: Text('E-wallet', style: text16BlackSemiBold),
    automaticallyImplyLeading: false,
    actions: [
      GestureDetector(
        onTap: () => Get.toNamed(Routes.CART),
        child: SvgPicture.asset(
          cart,
          // height: 14.wr,
          // fit: BoxFit.fitHeight,
        ),
      ),
      Gap(10.w),
      GestureDetector(
        onTap: () => Get.toNamed(Routes.NOTIFICATION),
        child: GetBuilder<FirebaseController>(
            init: FirebaseController(NotificationRepositoryImpl()),
            builder: (controller) {
              return Badge.count(
                count: controller.unreadCount,
                backgroundColor: kPrimaryColor,
                largeSize: 14,
                textStyle: TextStyle(fontSize: 8.sp, color: kWhite),
                isLabelVisible: controller.unreadCount > 0 ? true : false,
                offset: const Offset(2, -2),
                child: Icon(
                  Icons.notifications,
                  color: const Color(0xff333333).withOpacity(0.4),
                ),
              );
            }),
      ),
      Gap(16.w)
    ],
  );
}
