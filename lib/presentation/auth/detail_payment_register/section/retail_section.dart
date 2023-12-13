import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';

class RetailSection extends StatelessWidget {
  const RetailSection({super.key, required this.controller});
  final DetailPaymentRegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Text(controller.paymentCustomer?.channel?.code ?? '',
                        style: text12BlackSemiBold),
                    Image.asset(
                        fit: BoxFit.contain,
                        height: 24.h,
                        width: 44.w,
                        controller.assetImage(
                            controller.paymentCustomer?.channel?.code ?? 'BCA'))
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment Code', style: text12BlackRegular),
                          Gap(4.h),
                          Row(
                            children: [
                              Text(controller.paymentCustomer?.otc?.code ?? '',
                                  style: text14BlackMedium),
                              Gap(8.w),
                              SvgPicture.asset(copy)
                            ],
                          ),
                          Gap(8.h),
                          Text('Virtual Account Name',
                              style: text12BlackRegular),
                          Gap(4.h),
                          Text(controller.paymentCustomer?.otc?.name ?? '',
                              style: text14BlackMedium),
                        ],
                      ),
                      SizedBox(
                          width: 90.w,
                          height: 55.h,
                          child: SfBarcodeGenerator(
                            value: controller.paymentCustomer?.otc?.code ?? '',
                            showValue: true,
                            textStyle: text10BlackRegular,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(28.h),
        Divider(
          thickness: 1,
          color: kBorder,
          height: 0,
        ),
        Gap(12.h),
        Padding(
          padding: AppStyle.paddingVert16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              controller.tutorialPayment?.tab1?.length ?? 0,
              (index) => processStep(
                stepTitle: controller.tutorialPayment?.tab1?[index].title ?? '',
                stepDetails:
                    controller.tutorialPayment?.tab1?[index].content ?? [],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget processStep(
      {required String stepTitle, required List<String> stepDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepTitle,
          style: text12BlackSemiBold,
        ),
        Gap(6.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stepDetails
              .map((detail) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Text(
                      detail,
                      style: text12BlackRegular,
                    ),
                  ))
              .toList(),
        ),
        Gap(20.h),
      ],
    );
  }
}
