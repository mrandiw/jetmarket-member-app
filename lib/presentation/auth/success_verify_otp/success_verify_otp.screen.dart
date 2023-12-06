import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';

import '../../../components/button/app_button.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/success_verify_otp.controller.dart';

class SuccessVerifyOtpScreen extends GetView<SuccessVerifyOtpController> {
  const SuccessVerifyOtpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: AppStyle.paddingAll16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(sucessVerify)),
          Gap(24.h),
          Text('Verifikasi Berhasil', style: text20PrimarySemiBold),
          Gap(6.h),
          Text('Silakan selesaikan pembayaran.', style: text14BlackRegular),
          Gap(26.h),
          SizedBox(
            width: Get.width * 0.6,
            child: AppButton.primary(
                text: 'Lanjutkan',
                onPressed: () => Get.toNamed(Routes.PAYMENT_REGISTER)),
          )
        ],
      ),
    ));
  }
}
