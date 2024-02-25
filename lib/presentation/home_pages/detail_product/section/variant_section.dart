import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class VariantSection extends StatelessWidget {
  const VariantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${controller.detailProduct?.variants?.length} Variasi Tersedia',
              style: text12BlackRegular,
            ),
            Gap(12.h),
            SizedBox(
              height: 80.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => CachedNetworkImage(
                        imageUrl:
                            controller.detailProduct?.variants?[index].image ??
                                '',
                        imageBuilder: (context, imageProvider) =>
                            GestureDetector(
                          onTap: () => controller.selectVariant(
                              controller.detailProduct?.variants?[index]),
                          child: Container(
                            height: 80.r,
                            width: 80.r,
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.borderRadius8All,
                              color: kSofterGrey,
                              border: Border.all(
                                  color:
                                      (controller.selectedVariant?.id ?? 0) ==
                                              (controller.detailProduct
                                                      ?.variants?[index].id ??
                                                  0)
                                          ? kSecondaryColor
                                          : Colors.transparent),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SizedBox(
                          height: 80.r,
                          width: 80.r,
                          child: const Center(
                            child:
                                CupertinoActivityIndicator(color: kSoftBlack),
                          ),
                        ),
                        errorWidget: (context, url, error) => GestureDetector(
                          onTap: () => controller.selectVariant(
                              controller.detailProduct?.variants?[index]),
                          child: Container(
                            height: 80.r,
                            width: 80.r,
                            decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius8All),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius8All,
                                color: kSofterGrey,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: kPrimaryColor,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (_, i) => Gap(8.w),
                  itemCount: controller.detailProduct?.variants?.length ?? 0),
            ),
          ],
        ),
      );
    });
  }
}
