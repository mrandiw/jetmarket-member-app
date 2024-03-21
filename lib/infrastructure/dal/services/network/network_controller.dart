import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../presentation/main_pages/controllers/main_pages.controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text.dart';

class NetWorkController extends GetxController {
  final ping = Ping('google.com', timeout: 10);
  bool isMain = Get.isRegistered<MainPagesController>();

  @override
  void onInit() {
    ping.stream.listen((event) {
      if (event.error?.error == ErrorType.requestTimedOut) {
        Get.rawSnackbar(
            messageText:
                Text('Tidak ada koneksi internet', style: text12WhiteMedium),
            isDismissible: false,
            duration: 1.days,
            backgroundColor: kErrorColor,
            icon: Icon(Icons.wifi_off, color: kWhite, size: 26.r),
            padding: AppStyle.paddingAll16,
            snackStyle: SnackStyle.GROUNDED,
            mainButton: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text('Ulangi', style: text12WhiteRegular),
                ),
                Gap(12.w),
                GestureDetector(
                  onTap: () => SystemNavigator.pop(),
                  child: Text('Keluar', style: text12WhiteRegular),
                ),
                Gap(16.w),
              ],
            ));
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeAllSnackbars();
        }
      }
    });
    super.onInit();
  }
}
