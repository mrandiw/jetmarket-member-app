import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 140.r,
                width: 140.r,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: AppStyle.borderRadius8All,
                    boxShadow: [AppStyle.boxShadow]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_rounded,
                        color: kWarningColor, size: 56.r),
                    Gap(8.h),
                    Text(message ?? 'Error Response', style: text14BlackMedium)
                  ],
                )),
            Gap(22.h),
            SizedBox(
              width: 140.w,
              child: AppButton.primary(
                text: 'Kembali',
                onPressed: () => Get.back(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
