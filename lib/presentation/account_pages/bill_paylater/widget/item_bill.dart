import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';

import '../../../../domain/core/model/model_data/bill_paylater_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/style/app_style.dart';

class ItemBill extends StatelessWidget {
  const ItemBill({super.key, required this.data, required this.showYear});

  final BillPaylaterModel data;
  final bool showYear;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
          visible: showYear,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(12.h),
              Text('Tagihan Tahun ${data.dueAt?.getYear}',
                  style: text14BlackMedium),
              Gap(12.h),
              Divider(
                height: 0,
                color: kBorder,
                thickness: 1,
              )
            ],
          )),
      Gap(12.h),
      Text('${data.dueAt?.getMonthName}', style: text12HintRegular),
      Gap(12.h),
      GestureDetector(
        onTap: () {
          if (data.status == 'WAITING_PAYMENT') {
            Get.toNamed(Routes.DETAIL_BILL_PAYLATER,
                arguments: [data.refId, data.id, data.amount]);
          }
        },
        child: Container(
          padding: AppStyle.paddingAll12,
          height: 50.h,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: AppStyle.borderRadius8All,
            boxShadow: [AppStyle.boxShadow],
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '${data.amount}'.toIdrFormat,
              style: text12BlackMedium,
            ),
            const Spacer(),
            Text(status(data.status ?? ''),
                style: styleStatus(data.status ?? '')),
            Gap(8.w),
            Icon(
              Icons.chevron_right_rounded,
              color: kBlack,
              size: 18.r,
            )
          ]),
        ),
      )
    ]);
  }

  String status(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return 'Belum Dibayar';
      case 'PAID':
        return 'Telah Dibayar';
      default:
        return 'Bulan Depan';
    }
  }

  TextStyle styleStatus(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return text12PrimaryRegular;
      default:
        return text12HintRegular;
    }
  }
}
