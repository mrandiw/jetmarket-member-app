import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_menabung/controllers/detail_menabung.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class DetailSaving extends StatelessWidget {
  const DetailSaving({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailMenabungController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          Container(
            width: Get.width.wr,
            padding: AppStyle.paddingAll12,
            decoration: BoxDecoration(
              color: backgroundColor(controller.detailSaving?.status ?? ''),
              border: Border(
                left: BorderSide(
                    color: borderColor(controller.detailSaving?.status ?? ''),
                    width: 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconStatus(controller.detailSaving?.status ?? ''),
                  height: 22.r,
                  width: 22.r,
                ),
                Gap(8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.detailSaving?.noteTitle ?? '',
                        style: text12BlackMedium),
                    Gap(2.h),
                    Text(controller.detailSaving?.noteTitle ?? '',
                        style: text11GreyRegular),
                  ],
                ),
              ],
            ),
          ),
          Gap(12.hr),
          Text('Informasi Simpanan', style: text14BlackMedium),
          Gap(12.hr),
          Text('Tanggal Menabung', style: text12HintRegular),
          Gap(4.hr),
          Text(controller.detailSaving?.createdAt ?? '',
              style: text12BlackRegular),
          Gap(12.hr),
          Text('Nominal Simpanan', style: text12HintRegular),
          Gap(4.hr),
          Text("${controller.detailSaving?.amount ?? ''}".toIdrFormat,
              style: text12BlackSemiBold),
          Gap(12.hr),
          Text('Jumlah Simpanan saat ini', style: text12HintRegular),
          Gap(4.hr),
          Text("${controller.detailSaving?.totalAmount ?? ''}".toIdrFormat,
              style: text12BlackSemiBold),
        ],
      );
    });
  }

  Color backgroundColor(String status) {
    switch (status) {
      case 'PENDING':
        return kWarning2Color;
      default:
        return kSuccessColor;
    }
  }

  Color borderColor(String status) {
    switch (status) {
      case 'PENDING':
        return kWarningColor;
      default:
        return kSuccessColor2;
    }
  }

  String iconStatus(String status) {
    switch (status) {
      case 'PENDING':
        return historyCircle;
      default:
        return done;
    }
  }
}
