import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class PaymentMethode extends StatelessWidget {
  const PaymentMethode({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Metode Pembayaran', style: text14BlackMedium),
            Gap(8.h),
            Text('Transfer', style: text12BlackRegular),
            Gap(12.h),
            Text('Rincian Pembayaran', style: text14BlackMedium),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Harga (2 Barang)', style: text12BlackRegular),
                Text('30000'.toIdrFormat, style: text12BlackMedium),
              ],
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Ongkos Kirim', style: text12BlackRegular),
                Text('30000'.toIdrFormat, style: text12BlackMedium),
              ],
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Biaya Tambahan Penjual', style: text12BlackRegular),
                Text('30000'.toIdrFormat, style: text12BlackMedium),
              ],
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Biaya', style: text12BlackSemiBold),
                Text('30000'.toIdrFormat, style: text12BlackSemiBold),
              ],
            ),
          ],
        ));
  }
}
