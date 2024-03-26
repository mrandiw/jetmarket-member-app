import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (controller) {
      print(controller.totalPriceDiscount);
      return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rincian Pembayaran',
                style: text12BlackSemiBold,
              ),
              Gap(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Harga (${controller.totalProducts} Barang)',
                    style: text12HintRegular,
                  ),
                  Text(
                    "${controller.totalPriceProducts}".toIdrFormat,
                    style: text12BlackMedium,
                  )
                ],
              ),
              Gap(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Ongkos Kirim',
                    style: text12HintRegular,
                  ),
                  Text(
                    "${controller.totalPriceDelivery}".toIdrFormat,
                    style: text12BlackMedium,
                  )
                ],
              ),
              Gap(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Potongan',
                    style: text12HintRegular,
                  ),
                  Text(
                    "${controller.totalPriceDiscount.toInt()}".toIdrFormat,
                    style: text12BlackMedium,
                  )
                ],
              ),
              Gap(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Biaya',
                    style: text12BlackSemiBold.copyWith(
                        color: kBlack.withOpacity(0.7)),
                  ),
                  Text(
                    "${controller.totalPriceWithoutVoucher.toInt()}"
                        .toIdrFormat,
                    style: text12BlackMedium,
                  )
                ],
              )
            ],
          ));
    });
  }
}
