import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../../../../infrastructure/dal/repository/notification_repository_impl.dart';
import '../../../../infrastructure/dal/services/firebase/firebase_controller.dart';

AppBar get appBarAccount {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    title: Text('Akun Saya', style: text16BlackSemiBold),
    actions: [
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
