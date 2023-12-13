import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';

class FilterProduct extends StatelessWidget {
  const FilterProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return AppBottomSheet(
        title: 'Filters',
        textButton: 'Tampilkan Pesanan',
        gapBottom: 76,
        onPressed: controller.selectedCategoryProduct != "" ||
                controller.selectedStars != "" ||
                controller.selectedSortProduct != ""
            ? () => controller.applyFilterProduct()
            : null,
        child: _content(controller),
      );
    });
  }

  Widget _content(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(8.h),
        _sortFilter(controller),
        Gap(8.h),
        _starts(controller),
        Gap(16.h),
        _categoryProduct(controller)
      ],
    );
  }

  Column _sortFilter(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Urutkan', style: text14BlackMedium),
        Gap(8.h),
        Wrap(
          spacing: 8.0,
          children: List.generate(
            controller.sortProduct.length,
            (index) => ChoiceChip(
              elevation: 0,
              shadowColor: Colors.transparent,
              label: Text(
                controller.sortProduct[index],
                style: controller.selectedSortProduct ==
                        controller.sortProduct[index]
                    ? text12WhiteRegular
                    : text12HintRegular,
              ),
              backgroundColor: kWhite,
              selectedColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(
                      color: controller.selectedSortProduct ==
                              controller.sortProduct[index]
                          ? Colors.transparent
                          : kSoftGrey)),
              selected: controller.selectedSortProduct ==
                  controller.sortProduct[index],
              onSelected: (select) => controller.selectSortProduct(
                  select, controller.sortProduct[index]),
            ),
          ),
        ),
      ],
    );
  }

  Column _categoryProduct(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kategori', style: text14BlackMedium),
        Gap(8.h),
        Wrap(
          spacing: 8.0,
          children: List.generate(
            controller.categoryProduct.length,
            (index) => ChoiceChip(
              elevation: 0,
              shadowColor: Colors.transparent,
              label: Text(
                controller.categoryProduct[index],
                style: controller.selectedCategoryProduct ==
                        controller.categoryProduct[index]
                    ? text12WhiteRegular
                    : text12HintRegular,
              ),
              backgroundColor: kWhite,
              selectedColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(
                      color: controller.selectedCategoryProduct ==
                              controller.categoryProduct[index]
                          ? Colors.transparent
                          : kSoftGrey)),
              selected: controller.selectedCategoryProduct ==
                  controller.categoryProduct[index],
              onSelected: (select) => controller.selectCategoryProduct(
                  select, controller.categoryProduct[index]),
            ),
          ),
        ),
      ],
    );
  }

  Column _starts(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rating', style: text14BlackMedium),
        Gap(8.h),
        Row(
          children: [
            ChoiceChip(
              elevation: 0,
              shadowColor: Colors.transparent,
              label: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: kWarningColor,
                    size: 16.r,
                  ),
                  Gap(4.w),
                  Text(
                    "${controller.stars[0]} Ke atas",
                    style: controller.selectedStars == controller.stars[0]
                        ? text12WhiteRegular
                        : text12HintRegular,
                  ),
                ],
              ),
              backgroundColor: kWhite,
              selectedColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(
                      color: controller.selectedStars == controller.stars[0]
                          ? Colors.transparent
                          : kSoftGrey)),
              selected: controller.selectedStars == controller.stars[0],
              onSelected: (select) =>
                  controller.selectStarts(select, controller.stars[0]),
            ),
            const Spacer()
          ],
        ),
      ],
    );
  }
}
