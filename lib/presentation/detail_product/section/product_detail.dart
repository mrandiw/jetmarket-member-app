import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
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
              Text('Pensil Warna 2in1 12 Pcs Custom Warna',
                  style: text16BlackSemiBold),
              Gap(8.h),
              Row(
                children: [
                  Text('45300'.toIdrFormat, style: text16BlackSemiBold),
                  Gap(12.w),
                  Text('50300'.toIdrFormat, style: text14lineThroughRegular),
                ],
              ),
              Gap(8.h),
              Row(children: [
                Container(
                  height: 26.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                      color: kSecondaryColor2,
                      borderRadius: AppStyle.borderRadius6All),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rounded,
                          color: kWarningColor, size: 14.r),
                      Gap(4.w),
                      Text('4.5', style: text12PrimaryRegular)
                    ],
                  ),
                ),
                Gap(12.w),
                Text('21 Terjual', style: text12HintRegular)
              ]),
              Gap(16.h),
              Divider(height: 0, color: kDivider),
              Gap(16.h),
              Text('Deskripsi Produk', style: text16BlackSemiBold),
              Gap(16.h),
              Text('Deskripsi Produk', style: text16BlackSemiBold),
              Gap(16.h),
              Text(
                'Pensil Warna 2in1 isi 12 Pcs merk Joyki awet dan tidak mudah patah. Bebas pilih warna tulis di catatan pesanan.Bebas pilih warna tulis di catatan pesanan. Bebas pilih warna tulis di catatan pesanan. Bebas pilih warna tulis di catatan pesanan. Bebas pilih warna tulis di catatan pesanan. Bebas pilih warna tulis di catatan pesanan. Bebas pilih warna tulis di catatan pesanan ',
                style: text14BlackRegular,
                maxLines: controller.readMore ? 100 : 4,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(8.h),
              Row(
                children: [
                  TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: kSuccessColor),
                      onPressed: () => controller.onReadMore(),
                      child: Row(
                        children: [
                          Text(
                            controller.readMore
                                ? 'Sembunyikan'
                                : 'Baca Selengkapnya',
                            style: text12SucessRegular,
                          ),
                          Gap(12.w),
                          SvgPicture.asset(
                            controller.readMore ? arrowForward : arrowDown,
                            colorFilter: const ColorFilter.mode(
                                kSuccessColor, BlendMode.srcIn),
                          )
                        ],
                      )),
                  const Spacer()
                ],
              )
            ],
          );
        }));
  }
}
