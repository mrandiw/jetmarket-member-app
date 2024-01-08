import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class PaymentMethode extends StatelessWidget {
  const PaymentMethode({super.key, required this.controller});
  final DetailOrderController controller;

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
            Text(controller.detailOrderCustomer?.paymentMethod?.chCode ?? '',
                style: text12BlackRegular),
            Gap(12.h),
            Text('Rincian Pembayaran', style: text14BlackMedium),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Total Harga (${controller.detailOrderCustomer?.products?.length} Barang)',
                    style: text12BlackRegular),
                Text(
                    '${controller.detailOrderCustomer?.totalPrice}'.toIdrFormat,
                    style: text12BlackMedium),
              ],
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Ongkos Kirim', style: text12BlackRegular),
                Text(
                    '${controller.detailOrderCustomer?.totalOngkir}'
                        .toIdrFormat,
                    style: text12BlackMedium),
              ],
            ),
            // Gap(8.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Biaya Tambahan Penjual', style: text12BlackRegular),
            //     Text('30000'.toIdrFormat, style: text12BlackMedium),
            //   ],
            // ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Biaya', style: text12BlackSemiBold),
                Text(
                    '${controller.detailOrderCustomer?.totalAmount}'
                        .toIdrFormat,
                    style: text12BlackSemiBold),
              ],
            ),
          ],
        ));
  }
}
