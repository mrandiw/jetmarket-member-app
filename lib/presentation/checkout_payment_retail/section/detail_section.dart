import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/controllers/checkout_payment_retail.controller.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../utils/assets/assets_svg.dart';
import 'tabbar_section.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: AppStyle.paddingSide16,
          child: GetBuilder<CheckoutPaymentRetailController>(
              builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: AppStyle.borderRadius8All,
                      border: AppStyle.borderAll),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: AppStyle.paddingAll16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bank Negara Indonesia',
                                style: text12BlackSemiBold),
                            Image.asset(bni)
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: kDivider,
                        height: 0,
                      ),
                      SizedBox(
                        child: Padding(
                          padding: AppStyle.paddingAll16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Virtual Account Number',
                                  style: text12BlackRegular),
                              Gap(4.h),
                              Row(
                                children: [
                                  Text('88088123456778',
                                      style: text14BlackMedium),
                                  Gap(8.w),
                                  SvgPicture.asset(copy)
                                ],
                              ),
                              Gap(8.h),
                              Text('Virtual Account Name',
                                  style: text12BlackRegular),
                              Gap(4.h),
                              Text('XDT-TRATALION', style: text14BlackMedium),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(16.h),
                TabBarSection(controller: controller),
                SizedBox(
                    height: Get.height * 0.6,
                    child: TabBarView(
                        controller: controller.tabController,
                        children: const [
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                          SizedBox.shrink()
                        ]))
              ],
            );
          }),
        ),
      ],
    );
  }
}
