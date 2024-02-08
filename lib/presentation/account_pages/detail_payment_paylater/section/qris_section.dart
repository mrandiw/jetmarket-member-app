import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/detail_payment_paylater.controller.dart';

class QrisSection extends StatelessWidget {
  const QrisSection({super.key, required this.controller});

  final DetailPaymentPaylaterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(14.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1.h,
              width: 24.w,
              color: kDivider,
            ),
            Padding(
                padding: AppStyle.paddingSide8,
                child: Text('Scan QR untuk melakukan Pembayaran',
                    style: text12BlackRegular)),
            Container(
              height: 1.h,
              width: 24.w,
              color: kDivider,
            )
          ],
        ),
        Gap(8.h),
        Text('Kode QR untuk', style: text10BlackRegular),
        Gap(6.h),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                controller.assetsImageForQrisScreen.length,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Image.asset(
                          height: 18.h,
                          width: 32.w,
                          fit: BoxFit.contain,
                          controller.assetsImageForQrisScreen[index]),
                    ))),
        Gap(8.h),
        Text('dan aplikasi lainya', style: text10BlackRegular),
        Gap(22.h),
        Container(
          padding: AppStyle.paddingAll16,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: AppStyle.borderRadius8All,
            boxShadow: [AppStyle.boxShadow],
          ),
          child: SizedBox(
              width: 200.r,
              height: 200.r,
              child: SfBarcodeGenerator(
                  value: controller.waitingPayment?.qrCode?.code,
                  symbology: QRCode())),
        ),
        Gap(24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powered by', style: text10HintRegular),
            Gap(3.w),
            Image.asset('assets/images/qris.png', height: 9.h, width: 26.w),
          ],
        ),
        Gap(26.h),
      ],
    );
  }
}
