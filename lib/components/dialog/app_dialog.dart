import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../button/app_button.dart';

class AppDialog {
  static void show(
      {required Widget child, String? onTesText, Function()? onPressed}) {
    Get.dialog(Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: AppStyle.paddingAll16,
        decoration: BoxDecoration(
          borderRadius: AppStyle.borderRadius8All,
          color: kWhite,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 320.w, minHeight: 100.w),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(child: child),
                  Gap(16.h),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                          width: Get.width * 0.2,
                          child: AppButton.secondaryGrey(
                              text: "Batal", onPressed: () => Get.back())),
                      Gap(6.w),
                      SizedBox(
                          width: Get.width * 0.26,
                          child: AppButton.primary(
                              text: "$onTesText", onPressed: onPressed)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
