import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/tabungan_payment.controller.dart';
import 'tabbar_section.dart';
import 'tutorial_va_section.dart';

class VirtualAccountSection extends StatelessWidget {
  const VirtualAccountSection({super.key, required this.controller});
  final TabunganPaymentController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabunganPaymentController>(builder: (controller) {
      return Column(
        children: [
          Container(
            width: Get.width.wr,
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
                      Text(
                          "${controller.waitingPayment?.channel?.code ?? '-'} Virtual Account",
                          style: text12BlackSemiBold),
                      Image.asset(
                          fit: BoxFit.contain,
                          height: 24.h,
                          width: 44.w,
                          controller.assetImage(controller
                                  .waitingPayment?.channel?.code
                                  ?.toLowerCase() ??
                              'BCA'))
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
                            Text(
                                controller.waitingPayment?.virtualAccount
                                        ?.number ??
                                    '',
                                style: text14BlackMedium),
                            Gap(8.w),
                            GestureDetector(
                                onTap: () => controller.copyVa(controller
                                        .waitingPayment
                                        ?.virtualAccount
                                        ?.number ??
                                    ''),
                                child: SvgPicture.asset(copy))
                          ],
                        ),
                        Gap(8.h),
                        Text('Virtual Account Name', style: text12BlackRegular),
                        Gap(4.h),
                        Text(
                            controller.waitingPayment?.virtualAccount?.name ??
                                '-',
                            style: text14BlackMedium),
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
            height: Get.height * 0.8,
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tutorialPayment?.tabs
                      ?.asMap()
                      .entries
                      .map(
                        (entry) => TutorialVaSection(
                          data: controller.tutorialPayment!,
                          index: entry.key,
                        ),
                      )
                      .toList() ??
                  <Widget>[],
            ),
          )
        ],
      );
    });
  }
}
