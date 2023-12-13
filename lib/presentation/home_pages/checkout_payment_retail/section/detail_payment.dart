import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../utils/style/app_style.dart';

class DetailPayment extends StatelessWidget {
  const DetailPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet.witoutFooter(
        title: 'Detail Pembayaran', child: content);
  }

  Widget get content {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Gap(12.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Metode Pembayaran', style: text14BlackRegular),
          Text('Transfer Bank BNI', style: text14BlackRegular),
        ],
      ),
      Gap(24.h),
      Text('Total Belanja', style: text14BlackSemiBold),
      Gap(8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Harga (1 Barang)', style: text14BlackRegular),
          Text('45300'.toIdrFormat, style: text14BlackRegular),
        ],
      ),
      Gap(8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Ongkos Kirim', style: text14BlackRegular),
          Text('15300'.toIdrFormat, style: text14BlackRegular),
        ],
      ),
      Gap(8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Diskon Ongkos Kirim', style: text14BlackRegular),
          Text("-${'11300'.toIdrFormat}", style: text14PrimaryRegular),
        ],
      ),
      Gap(24.h),
      Row(
        children: [
          Text('Total Bayar', style: text16BlackSemiBold),
          Text('15300'.toIdrFormat, style: text16BlackSemiBold),
        ],
      ),
      Gap(24.h),
      Text('Barang yang dibeli', style: text14BlackSemiBold),
      Gap(8.h),
      Row(
        children: [
          ClipRRect(
            borderRadius: AppStyle.borderRadius8All,
            child: Image.network(
              'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              height: 50.r,
              width: 50.r,
              fit: BoxFit.cover,
            ),
          ),
          Gap(8.h),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Pensil Warna 2in1 12 Pcs', style: text14BlackSemiBold),
            Gap(6.h),
            Row(
              children: [
                Text('43000'.toIdrFormat, style: text14BlackRegular),
                Gap(8.w),
                Text('50000', style: text14lineThroughRegular),
              ],
            ),
          ])
        ],
      ),
      Gap(24.h),
      Text('Alamat Pengiriman', style: text14BlackRegular),
      Gap(6.h),
      Text('2118 Thornridge Cir. Syracuse, Connecticut 35624',
          style: text14HintRegular),
    ]);
  }
}
