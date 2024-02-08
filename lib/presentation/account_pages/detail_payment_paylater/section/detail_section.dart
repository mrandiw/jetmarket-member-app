import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../controllers/detail_payment_paylater.controller.dart';
import '../widget/paymen_type.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailPaymentPaylaterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width.wr,
                padding: AppStyle.paddingAll12,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: AppStyle.borderRadius8All,
                    boxShadow: [AppStyle.boxShadowSmall]),
                child: Column(
                  children: [
                    Gap(6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Bayar', style: text12BlackRegular),
                        Text(
                            "User ID: ${controller.waitingPayment?.referenceId}",
                            style: text12BlackMedium),
                      ],
                    ),
                    Gap(6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${controller.waitingPayment?.amount ?? 0}"
                                .toIdrFormat,
                            style: text14PrimarySemiBold),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(26.r)),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                timeLine,
                                colorFilter: const ColorFilter.mode(
                                    kWhite, BlendMode.srcIn),
                              ),
                              Gap(4.w),
                              Obx(() {
                                return Text(controller.formattedDuration.value,
                                    style: text12WhiteRegular);
                              })
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Gap(12.h),
              PaymentType(type: controller.methodeType, controller: controller)
            ],
          ),
        ),
      );
    });
  }
}
