import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/order/controllers/order.controller.dart';

class FilterOrder extends StatelessWidget {
  const FilterOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return AppBottomSheet(
        title: 'Filters',
        textButton: 'Tampilkan Pesanan',
        gapBottom: 76,
        onPressed: () => controller.applyFilterOrder(),
        child: _content(controller),
      );
    });
  }

  Widget _content(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(8.h),
        _sortFilter(controller),
        Gap(16.h),
        _statusOrder(controller)
      ],
    );
  }

  Column _sortFilter(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Urutkan', style: text14BlackMedium),
        Gap(8.h),
        Wrap(
          spacing: 8.0,
          children: List.generate(
            controller.sortOrders.length,
            (index) => ChoiceChip(
              elevation: 0,
              shadowColor: Colors.transparent,
              showCheckmark: false,
              label: Text(
                controller.sortOrders[index]['name'],
                style: controller.selectedFilterSortOrder ==
                        controller.sortOrders[index]
                    ? text12WhiteRegular
                    : text12HintRegular,
              ),
              backgroundColor: kWhite,
              selectedColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(
                      color: controller.selectedFilterSortOrder ==
                              controller.sortOrders[index]
                          ? Colors.transparent
                          : kSoftGrey)),
              selected: controller.selectedFilterSortOrder ==
                  controller.sortOrders[index],
              onSelected: (select) => controller.selectSortOrder(
                  select, controller.sortOrders[index]),
            ),
          ),
        ),
      ],
    );
  }

  Column _statusOrder(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status Pesanan', style: text14BlackMedium),
        Gap(8.h),
        Wrap(
          spacing: 8.0,
          children: List.generate(
            controller.statusTabs.length,
            (index) => ChoiceChip(
              elevation: 0,
              shadowColor: Colors.transparent,
              showCheckmark: false,
              label: Text(
                controller.statusTabs[index]['name'] ?? '',
                style: controller.selectedFilterStatusOrder ==
                        controller.statusTabs[index]
                    ? text12WhiteRegular
                    : text12HintRegular,
              ),
              backgroundColor: kWhite,
              selectedColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(
                      color: controller.selectedFilterStatusOrder ==
                              controller.statusTabs[index]
                          ? Colors.transparent
                          : kSoftGrey)),
              selected: controller.selectedFilterStatusOrder ==
                  controller.statusTabs[index],
              onSelected: (select) => controller.selectStatusOrder(
                  select, controller.statusTabs[index], index),
            ),
          ),
        ),
      ],
    );
  }
}
