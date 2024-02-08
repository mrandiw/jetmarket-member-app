import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/date_format.dart';

import '../../../../components/badge/app_badge.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/detail_bill_paylater.controller.dart';

class InfoOrderSection extends StatelessWidget {
  const InfoOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailBillPaylaterController>(builder: (controller) {
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
                      Text('${controller.detailBillPaylater?.refId}',
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
                      Text('${controller.detailBillPaylater?.customerName}',
                          style: text12BlackMedium),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Waktu Pemesanan', style: text12BlackRegular),
                      Text(
                          '${controller.detailBillPaylater?.createdAt?.split('.').first.formatDate}',
                          style: text12BlackMedium),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Waktu Pembayaran', style: text12BlackRegular),
                      Text(
                          '${controller.detailBillPaylater?.paymentMethod?.createdAt?.split('.').first.formatDate}',
                          style: text12BlackMedium),
                    ],
                  ),
                  Gap(6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status Pesanan', style: text12BlackRegular),
                      AppBadge(
                          icon: iconStatus(
                              controller.detailBillPaylater?.status ?? ''),
                          text: controller.convertTypeStatus(
                              controller.detailBillPaylater?.status ?? ''),
                          type: badgeType(controller.statusOrder))
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
                                  arguments: controller.detailBillPaylater?.id),
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

  String iconStatus(String status) {
    switch (status) {
      case "ON_DELIVERY":
      case "WAITING_CUSTOMER_CONFIRMATION":
        return cargo;
      case 'FINISHED':
      case 'REVIEWED':
        return done;
      case "PENDING":
      case "WAITING_DELIVERY":
      case "WAITING_PAYMENT":
      case "WAITING_SELLER_CONFIRMATION":
        return timeDash;
      case "REQUEST_REFUND_CUSTOMER":
      case "REFUNDED":
        return cancel;
      default:
        return cancel;
    }
  }

  AppBadgeType badgeType(String status) {
    switch (status) {
      case "ON_DELIVERY":
        return AppBadgeType.normal;
      case "WAITING_CUSTOMER_CONFIRMATION":
        return AppBadgeType.normalAccent;
      case 'FINISHED':
      case 'REVIEWED':
        return AppBadgeType.success;
      case "PENDING":
      case "WAITING_DELIVERY":
      case "WAITING_PAYMENT":
      case "WAITING_SELLER_CONFIRMATION":
        return AppBadgeType.waiting;
      case "REQUEST_REFUND_CUSTOMER":
      case "REFUNDED":
        return AppBadgeType.disable;
      default:
        return AppBadgeType.normal;
    }
  }
}
