import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../components/card/product_item.dart';

class ProductPopularSection extends StatelessWidget {
  const ProductPopularSection({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: AppStyle.paddingSide16,
      child: GetBuilder<HomeController>(builder: (controller) {
        return Visibility(
          visible: controller.popularProducts.isNotEmpty &&
              controller.searchActived == false,
          child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Produk Terlaris', style: text14BlackMedium),
                    GestureDetector(
                      onTap: () {
                        controller.seeAllPopular();
                      },
                      child: Row(
                        children: [
                          Text('Lihat semua', style: text12BlackRegular),
                          Gap(6.w),
                          SvgPicture.asset(arrowRight)
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(16.h),
                SizedBox(
                  height: 220.h,
                  width: Get.width,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => SizedBox(
                          width: 150.w,
                          child: Padding(
                            padding: AppStyle.paddingBottom12,
                            child: ProductItem(
                                onTap: () => controller.toDetailProduct(
                                      controller.popularProducts[index].id ?? 0,
                                    ),
                                item: controller.popularProducts[index]),
                          )),
                      separatorBuilder: (_, i) => Gap(12.h),
                      itemCount: controller.popularProducts.length),
                ),
                Gap(16.h),
                Text('Semua Produk', style: text14BlackMedium),
                Gap(16.h),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
