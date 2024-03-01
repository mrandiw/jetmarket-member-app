import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_tagihan_bulanan/controllers/detail_tagihan_bulanan.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class StatusTagihanBulanan extends StatelessWidget {
  const StatusTagihanBulanan({super.key, required this.controller});

  final DetailTagihanBulananController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.paddingAll12,
      width: Get.width.wr,
      decoration: BoxDecoration(
        color: backgroundColor(controller.detailLoan?.status ?? ''),
        border: Border(
          left: BorderSide(
              color: borderColor(controller.detailLoan?.status ?? ''),
              width: 2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(iconStatus(controller.detailLoan?.status ?? '')),
          Gap(8.wr),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.detailLoan?.note?.title ?? '',
                  style: text12BlackMedium),
              Gap(4.hr),
              Text(controller.detailLoan?.note?.description ?? '',
                  style: text12BlackRegular),
            ],
          )
        ],
      ),
    );
  }

  Color backgroundColor(String status) {
    switch (status) {
      case 'PENDING' || 'WAITING_PAYMENT' || 'WAITING_APPROVAL' || 'NEXT_MONTH':
        return kWarning2Color;
      case 'CANCELLED' || 'FAILED' || 'REJECTED':
        return kErrorColor2;
      default:
        return kSuccessColor2;
    }
  }

  Color borderColor(String status) {
    switch (status) {
      case 'PENDING' || 'WAITING_PAYMENT' || 'WAITING_APPROVAL' || 'NEXT_MONTH':
        return kWarningColor;
      case 'CANCELLED' || 'FAILED' || 'REJECTED':
        return kErrorColor;
      default:
        return kSuccessColor;
    }
  }

  String iconStatus(String status) {
    switch (status) {
      case 'PENDING' || 'WAITING_PAYMENT' || 'WAITING_APPROVAL' || 'NEXT_MONTH':
        return historyCircle;
      case 'CANCELLED' || 'FAILED' || 'REJECTED':
        return close;
      default:
        return done;
    }
  }
}
