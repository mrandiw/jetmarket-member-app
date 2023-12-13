import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';

class RetailCodeStep extends StatelessWidget {
  const RetailCodeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      Text('Alfamart', style: text12BlackRegular),
                      Image.asset(alfamart)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Payment Code', style: text12BlackRegular),
                            Gap(4.w),
                            Row(
                              children: [
                                Text('TEST723973', style: text14BlackMedium),
                                Gap(8.w),
                                GestureDetector(
                                    onTap: () {}, child: SvgPicture.asset(copy))
                              ],
                            )
                          ],
                        ),
                        Image.asset(barcode)
                      ],
                    ),
                    Gap(12.h),
                    Text('Virtual Account Name', style: text12BlackRegular),
                    Gap(4.w),
                    Text('TRATALION', style: text14BlackMedium),
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
          stepTitle: 'STEP 1: FIND NEAREST BRANCH',
          stepDetails: [
            '1. Visit the nearest Alfamart or Alfamidi branch before the time on the payment code/barcode runs out.',
            '2. Tell the cashier that you would like to make a payment and let them scan the barcode above.'
          ],
        ),
        Gap(12.h),
        processStep(
          stepTitle: 'STEP 2: PAYMENT DETAILS',
          stepDetails: [
            '1. Present the payment code/barcode to the cashier and confirm that the amount is correct.',
            '2. Proceed to make a payment with the amount on your payment code/barcode'
          ],
        ),
        Gap(12.h),
        processStep(
          stepTitle: 'STEP 3: TRANSACTION COMPLETED',
          stepDetails: [
            '1. Receive your proof of payment from the cashier.',
            '2. Your transaction is successful.'
          ],
        ),
      ]),
    );
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
