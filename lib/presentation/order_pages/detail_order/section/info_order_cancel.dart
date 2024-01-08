import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/date_format.dart';

import '../../../../components/badge/app_badge.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/detail_order.controller.dart';

class InfoOrderCancel extends StatelessWidget {
  const InfoOrderCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailOrderController>(builder: (controller) {
      return Column(
        children: [
          Padding(
              padding: AppStyle.paddingAll16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Info Pesanan', style: text14BlackMedium),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama Pembeli', style: text12BlackRegular),
                      Text(controller.detailOrderCustomer?.customerName ?? '',
                          style: text12BlackMedium),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Waktu Pemesanan', style: text12BlackRegular),
                      Text(
                          '${controller.detailOrderCustomer?.createdAt?.split('.').first.formatDate}',
                          style: text12BlackMedium),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status Pesanan', style: text12BlackRegular),
                      AppBadge(
                          icon: cancel,
                          text: controller.convertTypeStatus(
                              controller.detailOrderCustomer?.status ?? ''),
                          type: AppBadgeType.disable)
                    ],
                  ),
                ],
              )),
          Divider(
            height: 0,
            color: kDivider,
          )
        ],
      );
    });
  }
}
