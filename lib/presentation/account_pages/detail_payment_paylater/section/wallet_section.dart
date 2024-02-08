import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/detail_payment_paylater.controller.dart';

class WalletSection extends StatelessWidget {
  const WalletSection({super.key, required this.controller});

  final DetailPaymentPaylaterController controller;

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
                                .waitingPayment?.channel?.code
                                ?.toLowerCase() ??
                            'BCA'))
                  ],
                ),
              ),
              Visibility(
                  visible: controller.waitingPayment?.channel?.code == "OVO",
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
                                    controller.waitingPayment?.phone ??
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
        Visibility(
          visible: controller.waitingPayment?.ewallet?.qrCode == "" &&
              controller.waitingPayment?.ewallet?.deeplink != "",
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    controller.onTapQrCode(
                        controller.waitingPayment?.ewallet?.deeplink ?? '');
                  },
                  child:
                      Text('Buka Aplikasi', style: text14NormalAccentRegular)),
              Gap(26.h),
            ],
          ),
        ),
        Visibility(
          visible: controller.waitingPayment?.ewallet?.qrCode != "" &&
              controller.waitingPayment?.ewallet?.deeplink == "",
          child: Column(
            children: [
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
                    child: SfBarcodeGenerator(
                        value: controller.waitingPayment?.ewallet?.qrCode,
                        symbology: QRCode())),
              ),
              Gap(24.h),
              Text('SCAN UNTUK MEMBAYAR', style: text14BlackRegular),
              Gap(26.h),
            ],
          ),
        ),
        Visibility(
          visible: controller.waitingPayment?.ewallet?.qrCode != "" &&
              controller.waitingPayment?.ewallet?.deeplink != "",
          child: Column(
            children: [
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
                            controller.waitingPayment?.ewallet?.deeplink ?? '');
                      },
                      child: SfBarcodeGenerator(
                          value: controller.waitingPayment?.ewallet?.qrCode,
                          symbology: QRCode()),
                    )),
              ),
              Gap(24.h),
              Text('SCAN ATAU TAP QR', style: text14BlackRegular),
              Gap(4.h),
              Text('UNTUK MEMBAYAR', style: text14BlackRegular),
              Gap(26.h),
            ],
          ),
        ),
        Visibility(
            visible: controller.waitingPayment?.ewallet?.qrCode == "" &&
                controller.waitingPayment?.ewallet?.deeplink == "",
            child: Column(
              children: [
                Gap(12.hr),
                Text(
                    'Silahkan buka aplikasi ${controller.waitingPayment?.channel?.code} untuk mengkonfirmasi',
                    style: text12BlackRegular),
              ],
            )),
      ],
    );
  }
}
