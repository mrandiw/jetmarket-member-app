import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.controller});

  final DetailOrderController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.statusOrder == "delivery") {
      return Container(
        height: 72.h,
        padding: AppStyle.paddingAll16,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: AppStyle.borderRadius20Top,
            color: kWhite,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffE3BEBD).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -6))
            ]),
        child: Row(
          children: [
            AppButton.secondary(
              text: 'Ajukan Komplain',
              onPressed:
                  controller.onDelivery ? null : () => controller.toComplain(),
            ),
            Gap(12.w),
            AppButton.primary(
              text: 'Konfirmasi Pesanan',
              onPressed: controller.onDelivery
                  ? null
                  : () => controller.confirmOrder(),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
