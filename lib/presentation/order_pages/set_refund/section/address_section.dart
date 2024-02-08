import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/set_refund/controllers/set_refund.controller.dart';
import '../../../../infrastructure/theme/app_text.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetRefundController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Alamat Pengembalian', style: text14BlackMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.setRefundModel?.address?.label ?? '',
                  style: text12HintRegular),
              Gap(6.h),
              Row(
                children: [
                  Text(controller.setRefundModel?.address?.shopName ?? '',
                      style: text12HintRegular),
                  Gap(8.w),
                  Text(controller.setRefundModel?.address?.shopPhone ?? '',
                      style: text12HintRegular),
                ],
              ),
              Gap(6.h),
              Text(controller.setRefundModel?.address?.address ?? '',
                  style: text12HintRegular),
            ],
          ),
          Gap(16.h),
        ],
      );
    });
  }
}
