import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/account_pages/referral/controllers/referral.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class CodeReferralSection extends StatelessWidget {
  const CodeReferralSection({super.key, required this.controller});
  final ReferralController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: AppStyle.paddingAll12,
                  decoration: BoxDecoration(
                    borderRadius: AppStyle.borderRadius8All,
                    color: kWhite,
                    boxShadow: [AppStyle.boxShadow],
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: Get.width,
                          padding: AppStyle.paddingAll12,
                          decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius8All,
                            color: kPrimaryColor2,
                          ),
                          child: Text(
                            '${controller.codeRefferal}',
                            style: text12BlackSemiBold,
                          )),
                      Gap(12.h),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton.secondaryIcon(
                              icon: copy,
                              text: 'Salin',
                              onPressed: () => controller
                                  .copyVa(controller.codeRefferal ?? ''),
                            ),
                          ),
                          Gap(8.w),
                          Expanded(
                            child: AppButton.secondaryIcon(
                              icon: share,
                              text: 'Bagikan',
                              onPressed: () => controller.shareReferral(),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              Gap(16.h),
              Text('Riwayat', style: text14BlackSemiBold),
              Gap(16.h),
            ],
          )),
    );
  }
}
