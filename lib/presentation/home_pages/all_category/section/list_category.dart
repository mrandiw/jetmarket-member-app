import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/all_category/controllers/all_category.controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../components/form/app_form_icon.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCategoryController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          AppFormIcon(
            controller: controller.searchController,
            icon: search,
            hintText: 'Cari Kategori',
            onChanged: (value) => controller.searchCategory(value),
          ),
          Gap(16.h),
          Text('Kategori Produk', style: text14BlackMedium),
          Gap(12.h),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12.r,
            crossAxisSpacing: 12.r,
            children: List.generate(
              controller.categoryProduct.length,
              (index) => Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.categoryProduct[index].image ?? '',
                    imageBuilder: (context, imageProvider) => GestureDetector(
                      onTap: () => controller.toCategoryProduct(
                          controller.categoryProduct[index].id ?? 0),
                      child: Container(
                        height: 92.h,
                        decoration: BoxDecoration(
                          color: kSofterGrey,
                          borderRadius: AppStyle.borderRadius8All,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(color: kSoftBlack),
                    errorWidget: (context, url, error) => Container(
                      height: 92.h,
                      decoration: BoxDecoration(
                          color: kSofterGrey,
                          borderRadius: AppStyle.borderRadius6All),
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
                  Text(controller.categoryProduct[index].name ?? '',
                      style: text10BlackRegular),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
