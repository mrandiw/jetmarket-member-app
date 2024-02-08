import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/app_text.dart';

class AppSnackbarBlack {
  static void show(String message) {
    Get.showSnackbar(GetSnackBar(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
      backgroundColor: kBlack,
      duration: 2.seconds,
      borderRadius: 8.r,
      messageText: Text(message, style: text12WhiteRegular),
    ));
  }
}
