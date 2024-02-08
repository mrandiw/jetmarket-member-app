import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../controllers/detail_bill_paylater.controller.dart';

class InfoDelivery extends StatelessWidget {
  const InfoDelivery({super.key, required this.controller});

  final DetailBillPaylaterController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Info Pengiriman', style: text14BlackMedium),
            Gap(6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 5, child: Text('Kurir', style: text12BlackRegular)),
                const Spacer(),
                Expanded(
                    flex: 4,
                    child: Text(
                        "${controller.detailBillPaylater?.delivery?.serviceName?.capitalizeFirst} - ${controller.detailBillPaylater?.delivery?.code?.capitalizeFirst}",
                        style: text12BlackMedium)),
              ],
            ),
            Gap(6.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Text('Alamat', style: text12BlackRegular),
                        Gap(6.w),
                        SvgPicture.asset(copy),
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Text(
                      '${controller.detailBillPaylater?.address?.personName} ${controller.detailBillPaylater?.address?.address} ${controller.detailBillPaylater?.address?.posCode}',
                      style: text12BlackMedium),
                ),
              ],
            ),
          ],
        ));
  }
}
