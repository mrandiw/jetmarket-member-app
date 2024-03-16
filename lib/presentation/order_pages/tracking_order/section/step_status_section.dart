import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/date_format.dart';

import '../controllers/tracking_order.controller.dart';
import '../widget/custom_step_refund.dart';

class StepStatusSection extends StatelessWidget {
  const StepStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackingOrderController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomStepperRefund(currentStep: controller.trackingOrder?.step ?? 1),
          Gap(22.h),
          Text('Status Pesanan', style: text14BlackMedium),
          Gap(16.h),
          Column(
            children: List.generate(
                controller.trackingOrder?.deliveryEntries?.length ?? 1,
                (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  index == 0 ? kPrimaryColor : kSoftGrey,
                              radius: 7.r,
                            ),
                            Container(
                              height: 76.h,
                              width: 1,
                              color: kSoftGrey,
                            )
                          ],
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  controller.trackingOrder
                                          ?.deliveryEntries?[index].title ??
                                      ' ',
                                  style: index == 0
                                      ? text16PrimarySemiBold
                                      : text16HintSemiBold),
                              Gap(4.h),
                              Text(
                                  "${controller.trackingOrder?.deliveryEntries?[index].createdAt}"
                                      .convertToCustomFormat,
                                  style: text12HintRegular),
                              Gap(4.h),
                              Text(
                                  controller.trackingOrder
                                          ?.deliveryEntries?[index].content ??
                                      '',
                                  style: text12HintRegular)
                            ],
                          ),
                        )
                      ],
                    )),
          )
        ],
      );
    });
  }
}
