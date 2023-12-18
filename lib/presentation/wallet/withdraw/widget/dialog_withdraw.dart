import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class DialogWithdraw extends StatelessWidget {
  const DialogWithdraw({super.key, required this.rekening});
  final String rekening;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Withdraw ke', style: text12BlackRegular),
        Gap(8.h),
        Container(
          height: 36.h,
          width: Get.width,
          padding: AppStyle.paddingAll8,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll),
          child: Text(
            rekening,
            style: text12BlackRegular,
          ),
        )
      ],
    );
  }
}
