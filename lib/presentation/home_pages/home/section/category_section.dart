import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: GetBuilder<HomeController>(builder: (controller) {
      return Visibility(
        visible: controller.searchActived == false &&
            controller.categoryProduct.isNotEmpty,
        child: Padding(
            padding: AppStyle.paddingAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kategori Produk', style: text14BlackMedium),
                Gap(8.h),
                SizedBox(
                  height: 80.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            controller.categoryProduct.length,
                            (index) => Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: controller
                                                  .categoryProduct[index]
                                                  .image ??
                                              '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 57.h,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.red,
                                                          BlendMode.colorBurn)),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const CupertinoActivityIndicator(
                                                  color: kSoftBlack),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: 57.h,
                                            width: 57.h,
                                            decoration: BoxDecoration(
                                                color: kSofterGrey,
                                                borderRadius:
                                                    AppStyle.borderRadius6All),
                                            child: Center(
                                              child: Icon(
                                                Icons.error,
                                                color: kPrimaryColor,
                                                size: 18.r,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(6.h),
                                        Text(
                                            controller.categoryProduct[index]
                                                    .name ??
                                                '',
                                            style: text10BlackRegular),
                                      ],
                                    ),
                                  ),
                                ))),
                  ),
                ),
              ],
            )),
      );
    }));
  }
}
