import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/cart/controllers/cart.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
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
                Text('Total Harga', style: text14HintRegular),
                Text('${controller.totalPrice}'.toIdrFormat,
                    style: text20BlackSemiBold)
              ],
            )),
            AppButton.primary(
              text: 'Beli',
              onPressed: controller.addForBuy.isNotEmpty
                  ? () => controller.buyProduct()
                  : null,
            ),
          ],
        ),
      );
    });
  }
}
