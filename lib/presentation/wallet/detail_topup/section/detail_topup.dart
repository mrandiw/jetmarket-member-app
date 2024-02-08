import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/detail_topup/controllers/detail_topup.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../widget/status_topup_card.dart';

class DetailTopup extends StatelessWidget {
  const DetailTopup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailTopupController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          StatusTopupCard(
              type: type(controller.detailTopupModel?.status ?? ''),
              title: controller.detailTopupModel?.pinnedNote?.title ?? '',
              subtitle:
                  controller.detailTopupModel?.pinnedNote?.description ?? ''),
          Gap(16.h),
          Text('Status', style: text12HintRegular),
          Gap(8.h),
          Text(convertStatus(controller.detailTopupModel?.status ?? ''),
              style: text14BlackMedium),
          Gap(12.h),
          Text('Dibuat pada', style: text12HintRegular),
          Gap(6.h),
          Text(
              controller.detailTopupModel?.createdAt?.convertToCustomFormat ??
                  '',
              style: text12BlackRegular),
          Gap(12.h),
          Text('Terakhir Update', style: text12HintRegular),
          Gap(6.h),
          Text(
              controller.detailTopupModel?.updatedAt?.convertToCustomFormat ??
                  '',
              style: text12BlackRegular),
          Gap(18.h),
          Visibility(
            visible: controller.detailTopupModel?.status == 'WAITING_PAYMENT',
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.PAYMENT_TOPUP_SALDO,
                    arguments: controller.detailTopupModel?.refId ?? ''),
                child: Row(
                  children: [
                    Text('Lihat Cara Pembayaran',
                        style: text12NormalRegular.copyWith(
                            fontWeight: FontWeight.bold)),
                    Gap(2.w),
                    Icon(
                      Icons.chevron_right,
                      color: kNormalColor,
                      size: 18.r,
                    )
                  ],
                ),
              ),
            ),
          ),
          Text('Informasi Topup', style: text14BlackMedium),
          Gap(12.h),
          Text('Nama Lengkap', style: text12HintRegular),
          Gap(6.h),
          Text("${controller.detailTopupModel?.name}",
              style: text12BlackSemiBold),
          Gap(12.h),
          Text('Jumlah Topup', style: text12HintRegular),
          Gap(6.h),
          Text("${controller.detailTopupModel?.amount}".toIdrFormat,
              style: text12BlackSemiBold),
        ],
      );
    });
  }

  StatusTopupType type(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return StatusTopupType.waiting;
      case 'CANCELLED':
        return StatusTopupType.failed;
      default:
        return StatusTopupType.success;
    }
  }

  String convertStatus(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return 'Menunggu Pembayaran';
      case 'CANCELLED':
        return 'Dibatalkan';
      default:
        return 'Diterima';
    }
  }
}
