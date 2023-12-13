import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../components/badge/app_badge.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';

class InfoOrderDone extends StatelessWidget {
  const InfoOrderDone({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Text('John Doe', style: text12BlackMedium),
                  ],
                ),
                Gap(6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Waktu Pemesanan', style: text12BlackRegular),
                    Text('21 Nov 2023, 12:23', style: text12BlackMedium),
                  ],
                ),
                Gap(6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Waktu Pembayaran', style: text12BlackRegular),
                    Text('21 Nov 2023, 12:23', style: text12BlackMedium),
                  ],
                ),
                Gap(6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Waktu Pengiriman', style: text12BlackRegular),
                    Text('21 Nov 2023, 12:23', style: text12BlackMedium),
                  ],
                ),
                Gap(6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Waktu Pengiriman Selesai', style: text12BlackRegular),
                    Text('21 Nov 2023, 12:23', style: text12BlackMedium),
                  ],
                ),
                Gap(6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status Pesanan', style: text12BlackRegular),
                    const AppBadge(
                        icon: done, text: 'Selesai', type: AppBadgeType.success)
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
  }
}
