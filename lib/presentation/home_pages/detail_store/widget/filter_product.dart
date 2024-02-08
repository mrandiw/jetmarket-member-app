import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/controllers/detail_store.controller.dart';

class FilterProduct extends StatelessWidget {
  const FilterProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailStoreController>(builder: (controller) {
      return AppBottomSheet(
        title: 'Filters',
        textButton: 'Tampilkan Pesanan',
        gapBottom: 76,
        onPressed: controller.selectedCategoryProduct != null ||
                controller.selectedStars != null ||
                controller.selectedSortProduct != null
            ? () => controller.applyFilterProduct()
            : null,
        child: _content(controller),
      );
    });
  }

  Widget _content(DetailStoreController controller) {
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

  Column _sortFilter(DetailStoreController controller) {
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
              showCheckmark: false,
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

  Column _categoryProduct(DetailStoreController controller) {
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
              showCheckmark: false,
              label: Text(
                controller.categoryProduct[index].name ?? '',
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

  Column _starts(DetailStoreController controller) {
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
              showCheckmark: false,
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
