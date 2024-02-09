import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../components/button/app_button.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/assets/assets_svg.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/payletter_success.controller.dart';
import 'section/app_bar_section.dart';

class PayletterSuccessScreen extends GetView<PayletterSuccessController> {
  const PayletterSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.backtoMerchent();
      },
      child: Scaffold(
          appBar: appBarSuccessPayletter,
          backgroundColor: kWhite,
          body: Padding(
            padding: AppStyle.paddingAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset(successBlue)),
                Gap(26.h),
                Text('Paylater Berhasil', style: text20PrimarySemiBold),
                Gap(8.h),
                Text('Pembayaran dengan Paylater berhasil',
                    style: text14BlackRegular),
                Gap(26.h),
                AppButton.primary(
                  text: 'Lihat Rincian',
                  onPressed: () => controller.toDetail(),
                )
              ],
            ),
          )),
    );
  }
}
