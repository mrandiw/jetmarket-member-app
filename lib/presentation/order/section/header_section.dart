import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/presentation/order/controllers/order.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/form/app_form_icon.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/assets/assets_svg.dart';

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
                  ),
                ),
                Gap(12.w),
                GestureDetector(
                  onTap: null,
                  child: Container(
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
                )
              ],
            ),
            Gap(12.h),
            GestureDetector(
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
                    Text('Menunggu Pembayaran', style: text14BlackRegular),
                    const Spacer(),
                    CircleAvatar(
                      radius: 8.r,
                      backgroundColor: kPrimaryColor,
                      child: Text('1', style: text8WhiteRegular),
                    ),
                    Gap(8.w),
                    SvgPicture.asset(
                      arrowRight,
                      height: 14.r,
                      width: 14.r,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
