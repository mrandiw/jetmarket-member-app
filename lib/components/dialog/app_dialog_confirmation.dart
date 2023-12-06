import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/app_text.dart';
import '../button/app_button.dart';

class AppDialogConfirmation {
  static void show(
      {required String title,
      required String message,
      String? onTesText,
      Function()? onPressed}) {
    Get.defaultDialog(
        title: "",
        titlePadding: EdgeInsets.zero,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: text14BlackMedium,
            ),
            Gap(6.h),
            Text(
              message,
              style: text14BlackRegular,
            ),
          ],
        ),
        contentPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
        radius: 8.r,
        actions: [
          SizedBox(
              width: Get.width * 0.3,
              child: AppButton.secondaryGrey(
                  text: "Batal", onPressed: () => Get.back())),
          SizedBox(
              width: Get.width * 0.3,
              child: AppButton.primary(
                  text: "Ya, $onTesText", onPressed: onPressed)),
        ]);
  }
}
