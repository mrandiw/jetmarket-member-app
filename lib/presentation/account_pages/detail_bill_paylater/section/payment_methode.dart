import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../controllers/detail_bill_paylater.controller.dart';

class PaymentMethode extends StatelessWidget {
  const PaymentMethode({super.key, required this.controller});
  final DetailBillPaylaterController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Metode Pembayaran', style: text14BlackMedium),
              ],
            ),
            Gap(8.h),
            Text('Paylater', style: text12BlackRegular),
            Gap(12.h),
            Text('Rincian Pembayaran', style: text14BlackMedium),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Total Harga (${controller.detailBillPaylater?.products?.length} Barang)',
                    style: text12BlackRegular),
                Text('${controller.detailBillPaylater?.totalPrice}'.toIdrFormat,
                    style: text12BlackMedium),
              ],
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Ongkos Kirim', style: text12BlackRegular),
                Text(
                    '${controller.detailBillPaylater?.totalOngkir}'.toIdrFormat,
                    style: text12BlackMedium),
              ],
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Biaya', style: text12BlackSemiBold),
                Text(
                    '${controller.detailBillPaylater?.totalAmount}'.toIdrFormat,
                    style: text12BlackSemiBold),
              ],
            ),
          ],
        ));
  }
}
