import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/app_text.dart';
import '../../utils/style/app_style.dart';

class DialogNoConnection {
  static void show({Function()? onReload}) {
    Get.dialog(
        barrierDismissible: false,
        Dialog(
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
                    children: [
                      Icon(Icons.wifi_off, color: kErrorColor, size: 46.r),
                      Gap(8.h),
                      Text('Tidak ada koneksi internet',
                          style: text14BlackMedium),
                      Gap(16.h),
                      Row(
                        children: [
                          Expanded(
                              child: AppButton.secondaryGrey(
                                  text: "Keluar",
                                  onPressed: () => SystemNavigator.pop())),
                          Gap(12.w),
                          Expanded(
                              child: AppButton.primary(
                                  text: "Ulangi", onPressed: onReload)),
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
