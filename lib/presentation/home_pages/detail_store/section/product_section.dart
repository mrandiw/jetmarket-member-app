import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/controllers/detail_store.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailStoreController>(
        init: DetailStoreController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: AppStyle.paddingAll16,
              child: Column(
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
                      Gap(12.w),
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
                  SizedBox(
                    child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.r,
                        crossAxisSpacing: 10.r,
                        children: List.generate(9, (index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: AppStyle.borderRadius8All,
                              boxShadow: [AppStyle.boxShadow],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 92.h,
                                  decoration: BoxDecoration(
                                      borderRadius: AppStyle.borderRadius8Top,
                                      color: kSofterGrey,
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 32.wr,
                                        margin: AppStyle.paddingAll8,
                                        padding: EdgeInsets.all(4.r),
                                        decoration: BoxDecoration(
                                            color: kWhite,
                                            borderRadius:
                                                BorderRadius.circular(26.r)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star_rounded,
                                                color: kWarningColor,
                                                size: 14.r),
                                            Gap(4.w),
                                            Text('4.4',
                                                style: text10HintRegular)
                                          ],
                                        ),
                                      )),
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
