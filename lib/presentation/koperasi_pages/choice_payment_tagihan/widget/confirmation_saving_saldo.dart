import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/choice_payment/controllers/choice_payment.controller.dart';
import 'package:jetmarket/presentation/koperasi_pages/choice_payment_tagihan/controllers/choice_payment_tagihan.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class AppDialogConfirmationSaving {
  static void show({required ChoicePaymentTagihanController controller}) {
    Get.dialog(Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: AppStyle.paddingAll16,
        decoration: BoxDecoration(
          borderRadius: AppStyle.borderRadius8All,
          color: kWhite,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 320.w, minHeight: 100.w),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konfirmasi Pembayaran',
                    style: text14BlackMedium,
                  ),
                  Gap(6.h),
                  Text(
                    'Nominal',
                    style: text12HintRegular,
                  ),
                  Gap(4.h),
                  Text(
                    "${Get.arguments[1]}".toIdrFormat,
                    style: text12BlackRegular,
                  ),
                  Gap(6.h),
                  Text(
                    'Metode Pembayaran',
                    style: text12HintRegular,
                  ),
                  Gap(4.h),
                  Text(
                    controller.savingPaymentMethode?.saldo?[0].name ?? '',
                    style: text12BlackRegular,
                  ),
                  Gap(16.h),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                          width: Get.width * 0.24,
                          child: AppButton.secondaryGrey(
                              text: "Batal", onPressed: () => Get.back())),
                      Gap(6.w),
                      SizedBox(
                          width: Get.width * 0.34,
                          child: AppButton.primary(
                              text: "Konfirmasi",
                              onPressed: () {
                                controller.confirmationSavingSaldo();
                              })),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
