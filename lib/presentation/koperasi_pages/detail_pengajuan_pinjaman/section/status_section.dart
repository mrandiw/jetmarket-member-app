import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_pengajuan_pinjaman/controllers/detail_pengajuan_pinjaman.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class StatusPengajuanPinjaman extends StatelessWidget {
  const StatusPengajuanPinjaman({super.key, required this.controller});

  final DetailPengajuanPinjamanController controller;

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
      case 'PENDING':
        return kWarning2Color;
      case 'SUCCEEDED':
        return kSuccessColor2;
      default:
        return kBorder;
    }
  }

  Color borderColor(String status) {
    switch (status) {
      case 'PENDING':
        return kWarningColor;
      case 'SUCCEEDED':
        return kSuccessColor;
      default:
        return kGrey;
    }
  }

  String iconStatus(String status) {
    switch (status) {
      case 'PENDING':
        return historyCircle;
      case 'SUCCEEDED':
        return done;
      default:
        return canceled;
    }
  }
}
