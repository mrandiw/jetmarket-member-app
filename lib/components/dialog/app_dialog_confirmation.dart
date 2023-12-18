import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_text.dart';
import '../button/app_button.dart';

class AppDialogConfirmation {
  static void show(
      {required String title,
      required String message,
      String? onTesText,
      Function()? onPressed}) {
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
                  Text(
                    title,
                    style: text12BlackMedium,
                  ),
                  Gap(6.h),
                  Text(
                    message,
                    style: text12HintRegular,
                  ),
                  Gap(16.h),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                          width: Get.width * 0.24,
                          child: AppButton.secondaryGrey(
                              text: "Batal", onPressed: () => Get.back())),
                      Gap(6.w),
                      SizedBox(
                          width: Get.width * 0.34,
                          child: AppButton.primary(
                              text: "Ya, $onTesText", onPressed: onPressed)),
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
