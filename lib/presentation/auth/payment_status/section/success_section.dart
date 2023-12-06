import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_images.dart';
import '../../../../utils/style/app_style.dart';

class SuccessSection extends StatelessWidget {
  const SuccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(paymentSucess)),
          Gap(24.h),
          Text('Registrasi Berhasil', style: text20PrimarySemiBold),
          Gap(6.h),
          Text('Silakan cek email untuk verifikasi akunmu.',
              style: text14BlackRegular),
          Gap(26.h),
          SizedBox(
            width: Get.width * 0.6,
            child: AppButton.primary(
                text: 'Buka Email', onPressed: () => Get.back()),
          )
        ],
      ),
    );
  }
}
