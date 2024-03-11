import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/order/controllers/order.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form_icon.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.controller});
  final OrderController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppFormIcon(
                    controller: controller.searchController,
                    icon: search,
                    hintText: 'Cari pesanan',
                    onChanged: (value) => controller.searchOrders(value),
                  ),
                ),
                Gap(12.w),
                GestureDetector(
                    onTap: () => controller.openFilter(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 42.r,
                          width: 42.r,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: AppStyle.borderRadius8All,
                              border: AppStyle.borderAll),
                          child: Center(
                            child: SvgPicture.asset(miFilter),
                          ),
                        ),
                        GetBuilder<OrderController>(builder: (controller) {
                          return Visibility(
                            visible:
                                (controller.selectedFilterSortOrder != null ||
                                        controller.selectedFilterStatusOrder !=
                                            null) &&
                                    controller.isFiltered,
                            child: Positioned(
                                top: -2,
                                right: -2,
                                child: CircleAvatar(
                                  backgroundColor: kSecondaryColor,
                                  radius: 5.r,
                                )),
                          );
                        }),
                      ],
                    ))
              ],
            ),
            Gap(12.h),
            Visibility(
              visible: controller.waitingOrderCustomerLenght.value > 0,
              child: GestureDetector(
                onTap: () => controller.toWaitingPayment(),
                child: Container(
                  padding: AppStyle.paddingAll12,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: AppStyle.borderRadius8All,
                      border: AppStyle.borderAll),
                  child: Row(
                    children: [
                      SvgPicture.asset(paymentClock),
                      Gap(8.w),
                      Text('Menunggu Pembayaran', style: text12BlackRegular),
                      const Spacer(),
                      Obx(() {
                        return Visibility(
                          visible:
                              controller.waitingOrderCustomerLenght.value > 0,
                          child: CircleAvatar(
                            radius: 8.r,
                            backgroundColor: kPrimaryColor,
                            child: Text(
                                '${controller.waitingOrderCustomerLenght.value}',
                                style: text8WhiteRegular),
                          ),
                        );
                      }),
                      Gap(8.w),
                      SvgPicture.asset(
                        arrowRight,
                        height: 14.r,
                        width: 14.r,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
