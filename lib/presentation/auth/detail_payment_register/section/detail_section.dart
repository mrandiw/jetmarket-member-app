import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/widget/paymen_type.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../utils/assets/assets_svg.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Gap(276.hr),
          Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: AppStyle.borderRadius20Top),
            child: GetBuilder<DetailPaymentRegisterController>(
                builder: (controller) {
              return Column(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'RerID: #${controller.paymentCustomer?.referenceId ?? '-'}',
                                style: text12BlackRegular),
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
                                    return Text(
                                        controller.formattedDuration.value,
                                        style: text12WhiteRegular);
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                        Gap(6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nama Pengguna', style: text12BlackRegular),
                            Text(controller.paymentCustomer?.name ?? '-',
                                style: text12BlackMedium),
                          ],
                        ),
                        Gap(6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Bayar', style: text12BlackRegular),
                            Text(
                                "${controller.paymentCustomer?.amount ?? 0}"
                                    .toIdrFormat,
                                style: text14PrimarySemiBold),
                          ],
                        )
                      ],
                    ),
                  ),
                  Gap(12.h),
                  PaymentType(
                      type: controller.methodeType, controller: controller)
                ],
              );
            }),
          ),
        ],
      ),
    ));
  }
}
