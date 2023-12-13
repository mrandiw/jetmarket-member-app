import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

AppBar get appBarAccount {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0.3,
    title: Text('Akun Saya', style: text16BlackSemiBold),
    actions: [
      GestureDetector(
        onTap: () => Get.toNamed(Routes.NOTIFICATION),
        child: Icon(
          Icons.notifications,
          color: const Color(0xff333333).withOpacity(0.4),
        ),
      ),
      Gap(16.w)
    ],
  );
}
