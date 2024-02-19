import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/payment_success_retail.controller.dart';

class PaymentSuccessRetailScreen
    extends GetView<PaymentSuccessRetailController> {
  const PaymentSuccessRetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: AppStyle.paddingAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(paymentSuccess),
          ),
          Gap(24.h),
          Text('Thank You!', style: text20PrimarySemiBold),
          Gap(6.h),
          Text(
            'Your order #tratal-a822530396464180-8b864404a8c134c5 has been paid for successfully',
            textAlign: TextAlign.center,
            style: text14BlackRegular,
          ),
          Gap(26.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jumlah Bayar', style: text14BlackRegular),
              Text('43500'.toIdrFormat, style: text14BlackRegular)
            ],
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tanggal Bayar', style: text14BlackRegular),
              Text('01/12/2023  04:55pm', style: text14BlackRegular)
            ],
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pembayaran', style: text14BlackRegular),
              Text('OVO', style: text14BlackRegular)
            ],
          ),
          Gap(16.h),
          AppButton.primary(
            text: 'Kembali',
            onPressed: () => Get.back(),
          )
        ],
      ),
    ));
  }
}
