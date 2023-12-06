import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/controllers/checkout_payment_retail.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';

class SummaryPayment extends StatelessWidget {
  const SummaryPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child:
            GetBuilder<CheckoutPaymentRetailController>(builder: (controller) {
          return Container(
            padding: AppStyle.paddingAll12,
            decoration: BoxDecoration(
                borderRadius: AppStyle.borderRadius8All,
                boxShadow: [AppStyle.boxShadow],
                color: kWhite),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Bayar', style: text12BlackRegular),
                    Gap(6.h),
                    Text('33200'.toIdrFormat, style: text16PrimarySemiBold),
                  ],
                ),
                TextButton(
                    onPressed: () => controller.openDetailPayment(),
                    child: Text('Detail', style: text12NormalRegular))
              ],
            ),
          );
        }));
  }
}
