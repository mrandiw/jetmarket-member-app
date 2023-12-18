import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ProductDetailSection extends StatelessWidget {
  const ProductDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: GetBuilder<DetailProductController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.detailProduct?.name ?? '',
                  style: text16BlackSemiBold),
              Gap(8.h),
              Row(
                children: [
                  Text(
                      '${controller.selectedVariant?.price ?? (controller.detailProduct?.promo != 0 ? controller.detailProduct?.promo : controller.detailProduct?.price)}'
                          .toIdrFormat,
                      style: text16BlackSemiBold),
                  Gap(12.w),
                  Visibility(
                      visible: controller.detailProduct?.promo != 0,
                      child: Text(
                          '${controller.detailProduct?.price}'.toIdrFormat,
                          style: text14lineThroughRegular)),
                ],
              ),
              Gap(8.h),
              Row(children: [
                Container(
                  padding: EdgeInsets.all(4.wr),
                  decoration: BoxDecoration(
                      color: kSecondaryColor2,
                      borderRadius: AppStyle.borderRadius6All),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rounded,
                          color: kWarningColor, size: 14.r),
                      Gap(4.w),
                      Text("${controller.detailProduct?.rating}",
                          style: text12PrimaryRegular)
                    ],
                  ),
                ),
                Gap(12.w),
                Text('${controller.detailProduct?.sold} Terjual',
                    style: text12HintRegular),
                const Spacer(),
              ]),
              Gap(16.h),
              Divider(height: 0, color: kDivider),
              Gap(16.h),
              Text('Deskripsi Produk', style: text16BlackSemiBold),
              Gap(16.h),
              Text(
                '${controller.detailProduct?.description}',
                style: text14BlackRegular,
                maxLines: controller.readMore ? 100 : 4,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(8.h),
              Visibility(
                visible:
                    (controller.detailProduct?.description?.length ?? 0) > 176,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.onReadMore(),
                      child: SizedBox(
                        height: 28.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.readMore
                                  ? 'Sembunyikan'
                                  : 'Baca Selengkapnya',
                              style: text12SucessRegular,
                            ),
                            Gap(8.w),
                            Icon(
                                controller.readMore
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: kSuccessColor)
                          ],
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              )
            ],
          );
        }));
  }
}
