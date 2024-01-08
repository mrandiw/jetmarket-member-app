import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.controller});

  final DetailOrderController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailOrderController>(builder: (controller) {
      if (controller.statusOrder == "WAITING_CUSTOMER_CONFIRMATION") {
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
              Expanded(
                child: AppButton.secondary(
                  text: 'Ajukan Komplain',
                  onPressed: controller.onDelivery
                      ? null
                      : () => controller.toComplain(),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: AppButton.primary(
                  text: 'Konfirmasi Pesanan',
                  onPressed: controller.onDelivery
                      ? null
                      : () => controller.confirmOrder(),
                ),
              ),
            ],
          ),
        );
      } else if (controller.statusOrder == "PENDING" ||
          controller.statusOrder == "WAITING_DELIVERY" ||
          controller.statusOrder == "WAITING_PAYMENT" ||
          controller.statusOrder == "WAITING_SELLER_CONFIRMATION" ||
          controller.statusOrder == 'FINISHED') {
        return Container(
          height: 76.h,
          width: Get.width,
          padding: AppStyle.paddingAll16,
          decoration: BoxDecoration(color: kWhite, boxShadow: [
            BoxShadow(
                color: const Color(0xffE3BEBD).withOpacity(0.08),
                offset: const Offset(0, -6),
                blurRadius: 10)
          ]),
          child: controller.statusOrder != "REVIEWED"
              ? AppButton.primary(
                  text: controller.statusOrder == 'FINISHED'
                      ? 'Beri Review'
                      : 'Kembali',
                  onPressed: controller.statusOrder == 'FINISHED'
                      ? () => Get.toNamed(Routes.REVIEW_ORDER, arguments: [
                            controller.detailOrderCustomer?.trxId,
                            'review-detail'
                          ])
                      : () => Get.back(),
                )
              : AppButton.secondary(
                  text: 'Lihat Review',
                  onPressed: () {},
                ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
