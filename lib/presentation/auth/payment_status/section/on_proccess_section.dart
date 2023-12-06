import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../utils/assets/assets_svg.dart';

class OnProccessSection extends StatelessWidget {
  const OnProccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset(uimProcess)),
          Gap(24.h),
          Text('Permintaan Sedang Diproses', style: text20BlackSemiBold),
          Gap(6.h),
          Text('Mohon menunggu, pengajuan Anda sedang dalam proses.',
              textAlign: TextAlign.center, style: text14BlackRegular),
          Gap(26.h),
          SizedBox(
            width: Get.width * 0.6,
            child:
                AppButton.primary(text: 'Kembali', onPressed: () => Get.back()),
          )
        ],
      ),
    );
  }
}
