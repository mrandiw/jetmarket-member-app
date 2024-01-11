import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.controller});

  final DetailProductController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
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
            flex: 2,
            child: AppButton.secondaryIconFix(
              icon: chatLine,
              onPressed: () {},
            ),
          ),
          Gap(4.w),
          Expanded(
            flex: 4,
            child: Obx(() {
              return AppButton.secondaryIcon(
                actionStatus: controller.actionAddToCart.value,
                icon: plus,
                text: 'Keranjang',
                onPressed: () => controller.addToCart(),
              );
            }),
          ),
          Gap(4.w),
          Expanded(
            flex: 4,
            child: AppButton.primary(
              text: 'Beli Sekarang',
              onPressed: () => controller.buyProduct(),
            ),
          ),
        ],
      ),
    );
  }
}
