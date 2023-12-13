import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';

enum SnackType { success, error, dark }

class AppSnackbar {
  static void show(
      {String? message,
      SnackType type = SnackType.success,
      bool onTop = false}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: type == SnackType.success
          ? kSuccessColor
          : type == SnackType.dark
              ? kBlack
              : kErrorColor,
      message: message,
      duration: 2.seconds,
      icon: type == SnackType.dark
          ? const SizedBox.shrink()
          : Icon(
              type == SnackType.success
                  ? Icons.check_circle_rounded
                  : Icons.close,
              color: Colors.white,
              size: 18.r,
            ),
      padding:
          type == SnackType.dark ? AppStyle.paddingAll8 : AppStyle.paddingAll16,
      margin: type == SnackType.dark
          ? EdgeInsets.symmetric(vertical: 82.h, horizontal: 76.w)
          : EdgeInsets.all(16.r),
      borderRadius: 8.r,
      snackPosition: onTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    ));
  }
}
