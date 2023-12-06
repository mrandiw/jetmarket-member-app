import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';

class SummaryPayment extends StatelessWidget {
  const SummaryPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Container(
          padding: AppStyle.paddingAll12,
          decoration: BoxDecoration(
              borderRadius: AppStyle.borderRadius8All,
              boxShadow: [AppStyle.boxShadow],
              color: kWhite),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Bayar', style: text12BlackRegular),
                  Text('User ID: #92789JGB02', style: text12BlackRegular),
                ],
              ),
              Gap(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('33200'.toIdrFormat, style: text16PrimarySemiBold),
                  Container(
                    padding: AppStyle.paddingAll8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.r),
                        color: kPrimaryColor),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          timeLine,
                          colorFilter:
                              const ColorFilter.mode(kWhite, BlendMode.srcIn),
                        ),
                        Gap(6.w),
                        Text('23:59:47', style: text12WhiteRegular)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
