import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/product_bycategory/controllers/product_bycategory.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../utils/assets/assets_svg.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<ProductBycategoryController>(
        builder: (controller) {
          return Padding(
            padding: AppStyle.paddingAll16,
            child: Row(
              children: [
                Container(
                  height: 36,
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(26.r),
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(0.4),
                    ),
                  ),
                  child: DropdownButton<CategoryProduct>(
                    hint: Text(
                      'Pilih Kategori',
                      style: text11PrimaryRegular,
                    ),
                    style: text11PrimaryRegular,
                    value: controller.selectedCategoryProduct,
                    underline: const SizedBox.shrink(),
                    icon: SvgPicture.asset(arrowDown),
                    onChanged: (newValue) {
                      controller.selectCategory(newValue);
                    },
                    items: controller.categoryProduct.map((category) {
                      return DropdownMenuItem<CategoryProduct>(
                        value: category,
                        child: Text(category.name ?? '',
                            style: text11PrimaryRegular),
                      );
                    }).toList(),
                  ),
                ),
                const Spacer()
              ],
            ),
          );
        },
      ),
    );
  }
}
