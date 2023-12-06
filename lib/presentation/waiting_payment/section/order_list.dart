import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/waiting_payment/controllers/waiting_payment.controller.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaitingPaymentController>(builder: (controller) {
      return ListView.builder(
          padding: AppStyle.paddingAll16,
          itemCount: 2,
          itemBuilder: (_, index) {
            return Padding(
              padding: AppStyle.paddingBottom8,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: AppStyle.borderRadius8All,
                    side: AppStyle.borderSide),
                child: Padding(
                  padding: AppStyle.paddingAll12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        SvgPicture.asset(timeLine),
                        Gap(8.w),
                        Text(
                          'Bayar Sebelum',
                          style: text12BlackRegular,
                        ),
                        const Spacer(),
                        Text('30-08-2023  23:00', style: text12WarningMedium)
                      ]),
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('BCA Virtual Account',
                                    style: text12BlackMedium),
                                Gap(4.h),
                                Text('80777082323872832',
                                    style: text12BlackRegular),
                              ]),
                          Image.asset(bni)
                        ],
                      ),
                      Gap(12.h),
                      Text('Pembelian Pensil Warna 2in1 12 Pcs',
                          style: text12BlackMedium),
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Pembayaran:',
                                    style: text10BlackRegular),
                                Gap(4.h),
                                Text('23000', style: text16PrimarySemiBold),
                              ]),
                          AppButton.secondary(
                            text: 'Lihat Cara Bayar',
                            onPressed: () => controller.toCaraBayar(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
