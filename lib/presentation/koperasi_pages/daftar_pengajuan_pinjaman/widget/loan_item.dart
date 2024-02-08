import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/loan_propose_model.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class LoanItem extends StatelessWidget {
  const LoanItem({super.key, required this.data});

  final LoanProposeModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.DETAIL_PENGAJUAN_PINJAMAN, arguments: data.id),
      child: Container(
          padding: AppStyle.paddingAll12,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(iconStatus(data.status ?? '')),
              Gap(12.wr),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data.note?.title ?? '', style: text12BlackMedium),
                      Text(data.createdAt?.formatDate ?? '',
                          style: text8GreyRegular)
                    ],
                  ),
                  Gap(4.hr),
                  Text(
                    data.note?.description ?? '',
                    style: text11GreyRegular,
                  ),
                  Visibility(
                    visible: data.status == 'REJECT',
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: GestureDetector(
                          onTap: () =>
                              Get.toNamed(Routes.DETAIL_PENGAJUAN_PINJAMAN),
                          child: Text('Lihat Detail',
                              style: text11PrimaryRegular)),
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }

  String iconStatus(String status) {
    switch (status) {
      case 'PENDING':
        return historyCircle;
      case 'CANCELLED':
        return canceled;
      default:
        return done;
    }
  }
}
