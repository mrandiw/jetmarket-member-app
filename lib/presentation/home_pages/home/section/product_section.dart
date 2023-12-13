import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: AppStyle.paddingAll16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppFormIcon(
                          controller: controller.searchController,
                          icon: search,
                          hintText: 'Cari produk',
                        ),
                      ),
                      Gap(10.wr),
                      GestureDetector(
                        onTap: () => controller.openFilter(),
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
                  Gap(16.h),
                  Text('Kategori Produk', style: text14BlackMedium),
                  Gap(8.h),
                  SizedBox(
                    height: 80.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              controller.listCategory.length,
                              (index) => Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: "",
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
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CupertinoActivityIndicator(
                                                    color: kSoftBlack),
                                            errorWidget:
                                                (context, url, error) =>
                                                    SizedBox(
                                              height: 57.h,
                                              child: const Icon(
                                                Icons.error,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                          Gap(6.h),
                                          Text(
                                              controller.listCategory[index]
                                                  ['name'],
                                              style: text10BlackRegular),
                                        ],
                                      ),
                                    ),
                                  ))),
                    ),
                  ),
                  Gap(16.h),
                  Text('Semua Produk', style: text14BlackMedium),
                  Gap(16.h),
                  SizedBox(
                    child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.r,
                        crossAxisSpacing: 10.r,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: () => controller.toDetailProduct(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadow],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 92.h,
                                      decoration: BoxDecoration(
                                        borderRadius: AppStyle.borderRadius8Top,
                                        color: kSofterGrey,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: 42.wr,
                                            margin: AppStyle.paddingAll8,
                                            padding: EdgeInsets.all(4.r),
                                            decoration: BoxDecoration(
                                                color: kWhite,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        26.r)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star_rounded,
                                                    color: kWarningColor,
                                                    size: 14.hr),
                                                Gap(4.w),
                                                Text('4.4',
                                                    style: text10HintRegular)
                                              ],
                                            ),
                                          )),
                                    ),
                                    placeholder: (context, url) => SizedBox(
                                      height: 92.h,
                                      width: Get.width,
                                      child: const Center(
                                        child: CupertinoActivityIndicator(
                                            color: kSoftBlack),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      height: 92.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              AppStyle.borderRadius8Top),
                                      child: Center(
                                        child: Icon(
                                          Icons.error,
                                          color: kPrimaryColor,
                                          size: 18.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: AppStyle.paddingAll12,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Buku Jurnal',
                                              style: text12BlackRegular),
                                          Gap(2.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('20000'.toIdrFormat,
                                                  style: text14SuccessSemiBold),
                                              Text('24000'.toIdrFormat,
                                                  style:
                                                      text10lineThroughRegular),
                                            ],
                                          ),
                                          Gap(4.h),
                                          Text('Terjual 56',
                                              style: text10HintRegular),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          );
                        })),
                  )
                ],
              ),
            ),
          );
        });
  }
}
