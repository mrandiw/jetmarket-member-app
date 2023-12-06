import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_text.dart';

class DeliverySection extends StatelessWidget {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: GetBuilder<CheckoutController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(12.h),
            Text('Pengiriman', style: text14BlackMedium),
            Gap(12.h),
            Column(
                children: List.generate(
                    controller.deliverys.length,
                    (index) => Padding(
                          padding: AppStyle.paddingBottom8,
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: AppStyle.borderRadius8All,
                                side: AppStyle.borderSide),
                            child: ListTile(
                              onTap: () => controller.selectDelivery(index),
                              contentPadding: AppStyle.paddingSide12,
                              title: Text(
                                  "${controller.deliverys[index]['name']} (${controller.deliverys[index]['price'].toString().toIdrFormat})",
                                  style: text12BlackRegular),
                              subtitle: Text(
                                'Extimasi Tiba ${controller.deliverys[index]['estimasi']} Des',
                                style: text12HintRegular,
                              ),
                              trailing: SizedBox(
                                width: 26.w,
                                child: RadioListTile(
                                    activeColor: kPrimaryColor,
                                    value: index,
                                    selected:
                                        controller.selectedDelivery == index,
                                    groupValue: controller.selectedDelivery,
                                    onChanged: (value) =>
                                        controller.selectDelivery(value!)),
                              ),
                            ),
                          ),
                        ))),
            Gap(8.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.VOUCHER);
              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: AppStyle.borderRadius8All,
                    side: AppStyle.borderSide),
                child: Padding(
                  padding: AppStyle.paddingAll12,
                  child: Row(
                    children: [
                      SvgPicture.asset(voucher),
                      Gap(8.w),
                      Text('Voucher', style: text12BlackRegular),
                      const Spacer(),
                      SvgPicture.asset(arrowRight)
                    ],
                  ),
                ),
              ),
            ),
            Gap(18.h),
          ],
        );
      }),
    );
  }
}
