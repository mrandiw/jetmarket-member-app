import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/controllers/detail_store.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../infrastructure/theme/app_colors.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.controller});
  final DetailStoreController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppStyle.paddingAll16,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: kBorder,
              height: 0,
              thickness: 1,
            );
          },
          itemCount: controller.categoryProduct.length,
          itemBuilder: (BuildContext context, int index) {
            Widget content = ListTile(
              onTap: () => controller.toProductByCategory(
                  controller.detailShop?.id ?? 0,
                  controller.categoryProduct[index]),
              contentPadding: AppStyle.paddingVert12,
              leading: CachedNetworkImage(
                imageUrl: controller.categoryProduct[index].image ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  height: 50.r,
                  width: 50.r,
                  decoration: BoxDecoration(
                      borderRadius: AppStyle.borderRadius8All,
                      color: kSofterGrey,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                placeholder: (context, url) => SizedBox(
                  height: 50.r,
                  width: 50.r,
                  child: const Center(
                    child: CupertinoActivityIndicator(color: kSoftBlack),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 50.r,
                  width: 50.r,
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
              title: Text(controller.categoryProduct[index].name ?? '',
                  style: text14BlackRegular),
            );

            return content;
          },
        ),
      ),
    );
  }
}
