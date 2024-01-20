import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/cara_bayar.controller.dart';

class WalletSection extends StatelessWidget {
  const WalletSection({super.key, required this.controller});

  final CaraBayarController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppStyle.paddingAll16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("EWallet", style: text12BlackSemiBold),
                    Image.asset(
                        fit: BoxFit.contain,
                        height: 24.h,
                        width: 44.w,
                        controller.assetImage(controller
                                .paymentCustomer?.channel?.code
                                ?.toLowerCase() ??
                            'BCA'))
                  ],
                ),
              ),
              Visibility(
                  visible: controller.paymentCustomer?.channel?.code == "OVO",
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          thickness: 1,
                          color: kDivider,
                          height: 0,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: AppStyle.paddingAll16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nomor Hp', style: text12BlackRegular),
                                Gap(6.h),
                                Text(
                                    controller.paymentCustomer?.phone ??
                                        '08123494484',
                                    style: text14BlackRegular),
                              ],
                            ),
                          ),
                        ),
                      ]))
            ],
          ),
        ),
        Gap(22.h),
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: AppStyle.borderRadius8All,
            boxShadow: [AppStyle.boxShadow],
          ),
          child: SizedBox(
              width: 200.r,
              height: 200.r,
              child: GestureDetector(
                onTap: () {
                  controller.onTapQrCode(
                      controller.paymentCustomer?.ewallet?.deeplink ?? '');
                },
                child: SfBarcodeGenerator(
                    value: controller.paymentCustomer?.ewallet?.qrCode,
                    symbology: QRCode()),
              )),
        ),
        Gap(24.h),
        Text('SCAN ATAU TAP QR', style: text14BlackRegular),
        Gap(4.h),
        Text('UNTUK MEMBAYAR', style: text14BlackRegular),
        Gap(26.h),
      ],
    );
  }
}
