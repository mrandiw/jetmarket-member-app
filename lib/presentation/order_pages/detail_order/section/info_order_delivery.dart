import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/badge/app_badge.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/navigation/routes.dart';

class InfoOrderDelivery extends StatelessWidget {
  const InfoOrderDelivery({super.key});

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
                      Text(controller.detailOrderCustomer?.trxRef ?? '',
                          style: text12BlackRegular),
                      // GestureDetector(
                      //   child:
                      //       Text('Lihat Invoice', style: text12SucessRegular),
                      // ),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama Pembeli', style: text12BlackRegular),
                      Text('${controller.detailOrderCustomer?.customerName}',
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
                      Text('Waktu Pembayaran', style: text12BlackRegular),
                      Text(
                          '${controller.detailOrderCustomer?.paymentMethod?.createdAt?.split('.').first.formatDate}',
                          style: text12BlackMedium),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status Pesanan', style: text12BlackRegular),
                      AppBadge(
                          icon: cargo,
                          text: controller.convertTypeStatus(
                              controller.detailOrderCustomer?.status ?? ''),
                          type: controller.statusOrder == 'ON_DELIVERY'
                              ? AppBadgeType.normal
                              : AppBadgeType.normalAccent)
                    ],
                  ),
                  Visibility(
                    visible: controller.statusOrder == 'ON_DELIVERY',
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.TRACKING_ORDER,
                                  arguments:
                                      controller.detailOrderCustomer?.id),
                              child: Text(
                                'Lacak Pesanan',
                                style: text12SucessRegular,
                              ))),
                    ),
                  )
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
