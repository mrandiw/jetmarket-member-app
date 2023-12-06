import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/presentation/checkout_payment/controllers/checkout_payment.controller.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/controllers/checkout_payment_retail.controller.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';

class FormEwalletSection extends StatelessWidget {
  const FormEwalletSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutPaymentRetailController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingSide16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: AppStyle.borderRadius8All,
                  color: kWhite,
                  border: AppStyle.borderAll),
              child: Column(
                children: [
                  Padding(
                      padding: AppStyle.paddingAll12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('OVO', style: text12BlackRegular),
                          Image.asset(ovo)
                        ],
                      )),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: kDivider,
                  ),
                  Padding(
                    padding: AppStyle.paddingAll16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppForm(
                          type: AppFormType.withLabel,
                          label: 'No. Hp',
                          hintText: 'Masukkan no. handphone',
                          controller: controller.phoneController,
                          onChanged: (value) {
                            controller.numberPhone(value);
                          },
                        ),
                        Gap(12.h),
                        Row(children: [
                          const Spacer(),
                          AppButton.secondaryGrey(
                            text: 'Batal',
                            onPressed: () => Get.back(),
                          ),
                          Gap(8.w),
                          AppButton.primary(
                            text: 'Bayar',
                            onPressed: controller.isPaymentReady
                                ? () => controller.toPaymentSuccess()
                                : null,
                          )
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(22.h),
            Divider(
              height: 0,
              thickness: 1,
              color: kDivider,
            ),
            Gap(22.h),
            processStep(
              stepTitle: 'IF THE TRANSACTION FAILS, PLEASE TRY THE FOLLOWING:',
              stepDetails: [
                '1. Input your phone number again and try paying again.',
                '2. Clear your OVO app cache on your phone.',
                '3. If the problem continues, please contact Xendit for support.'
              ],
            ),
            Gap(8.h),
            RichText(
              text: TextSpan(
                  text: 'You will',
                  style: text12BlackRegular,
                  children: [
                    TextSpan(
                        text: ' NOT be charged twice for retrying',
                        style: text12BlackSemiBold)
                  ]),
            )
          ],
        ),
      );
    });
  }

  Widget processStep(
      {required String stepTitle, required List<String> stepDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepTitle,
          style: text12BlackSemiBold,
        ),
        Gap(6.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stepDetails
              .map((detail) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Text(
                      detail,
                      style: text12BlackRegular,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
