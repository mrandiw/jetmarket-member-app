import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
                border: Border(
                    bottom: AppStyle.borderSide, top: AppStyle.borderSide)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ulasan Produk', style: text16BlackSemiBold),
                Gap(8.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: kWarningColor, size: 18.r),
                    Gap(2.w),
                    Text('4.5/5.0', style: text12BlackRegular),
                    Gap(4.w),
                    Text('(54 Ulasan)', style: text12HintRegular),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: AppStyle.paddingSide16,
            decoration:
                BoxDecoration(border: Border(bottom: AppStyle.borderSide)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Galeri Pembeli', style: text14BlackRegular),
                    const Spacer(),
                    TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: kPrimaryColor),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text('Lihat semua', style: text12BlackRegular),
                          Gap(6.w),
                          SvgPicture.asset(arrowRight)
                        ],
                      ),
                    )
                  ],
                ),
                Wrap(
                  spacing: 8.w,
                  children: List.generate(
                      4,
                      (index) => ClipRRect(
                            borderRadius: AppStyle.borderRadius8All,
                            child: Image.network(
                              'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              height: 70.h,
                              width: 75.w,
                              fit: BoxFit.cover,
                            ),
                          )),
                ),
                Gap(16.h),
              ],
            ),
          ),
          Gap(16.h),
          Padding(
            padding: AppStyle.paddingSide16,
            child: Column(
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: AppStyle.paddingVert8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: kPrimaryColor2,
                              ),
                              Gap(8.w),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('Laura', style: text14BlackMedium),
                                    Gap(4.h),
                                    Row(
                                        children: List.generate(
                                            5,
                                            (index) => Icon(
                                                  Icons.star_rounded,
                                                  color: index != 4
                                                      ? kWarningColor
                                                      : kWarningColor
                                                          .withOpacity(0.4),
                                                  size: 22.r,
                                                ))),
                                    Gap(12.h),
                                    ClipRRect(
                                      borderRadius: AppStyle.borderRadius8All,
                                      child: Image.network(
                                        'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                        height: 70.h,
                                        width: 75.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(12.h),
                                    Text('Lorem ipsum dolor sit amet..',
                                        style: text14HintRegular)
                                  ]))
                            ],
                          ),
                        ))),
          )
        ],
      );
    });
  }
}
