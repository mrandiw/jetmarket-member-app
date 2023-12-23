import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (controller) {
      return Container(
        height: 88.h,
        padding: AppStyle.paddingAll16,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: AppStyle.borderRadius20Top,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffE3BEBD).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -6))
            ]),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Pembayaran', style: text14HintRegular),
                Text('${controller.totalPrice.toInt()}'.toIdrFormat,
                    style: text20BlackSemiBold)
              ],
            )),
            AppButton.primary(
              text: 'Bayar Sekarang',
              onPressed: controller.selectedDelivery != 99
                  ? () => controller.toChoicePayment()
                  : null,
            ),
          ],
        ),
      );
    });
  }
}
