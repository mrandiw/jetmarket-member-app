import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/rincian_refund/controllers/rincian_refund.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({super.key, required this.controller});

  final RincianRefundController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width.wr,
      padding: AppStyle.paddingAll12,
      decoration: const BoxDecoration(
        color: kSuccessColor2,
        border: Border(
          left: BorderSide(color: kSuccessColor, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.detailRefund?.note?.title ?? '',
              style: text12BlackMedium),
          Gap(2.h),
          Text(controller.detailRefund?.note?.description ?? '',
              style: text11GreyRegular),
        ],
      ),
    );
  }
}
