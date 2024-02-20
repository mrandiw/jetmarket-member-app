import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/presentation/account_pages/bill_paylater/widget/item_bill.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/infiniti_page/infiniti_page.dart';
import '../../../domain/core/model/model_data/bill_paylater_model.dart';
import 'controllers/bill_paylater.controller.dart';
import 'section/app_bar_section.dart';

class BillPaylaterScreen extends GetView<BillPaylaterController> {
  const BillPaylaterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBillPaylater,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
              padding: AppStyle.paddingAll16,
              sliver: PagedSliverList.separated(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<BillPaylaterModel>(
                    itemBuilder: (context, item, index) {
                      final currentData =
                          controller.pagingController.itemList?[index];
                      final previousData = index > 0
                          ? controller.pagingController.itemList![index - 1]
                          : null;
                      final showYearLabel = previousData == null ||
                          currentData?.dueAt?.getYear !=
                              previousData.dueAt?.getYear;

                      return ItemBill(
                        data: item,
                        showYear: showYearLabel,
                      );
                    },
                    newPageProgressIndicatorBuilder: InfinitiPage.progress,
                    firstPageProgressIndicatorBuilder: InfinitiPage.progress,
                    noItemsFoundIndicatorBuilder: (_) =>
                        InfinitiPage.empty(_, 'Tagihan'),
                    firstPageErrorIndicatorBuilder: InfinitiPage.error,
                  ),
                  separatorBuilder: (_, i) => Gap(12.h))),
        ],
      ),

      // body: ListView.separated(
      //     padding: AppStyle.paddingAll16,
      //     itemBuilder: (_, index) {
      //       final currentData = controller.billPaylater[index];
      //       final previousData =
      //           index > 0 ? controller.billPaylater[index - 1] : null;
      //       final showYearLabel = previousData == null ||
      //           currentData.dueAt?.getYear != previousData.dueAt?.getYear;

      //       return ItemBill(
      //         data: controller.billPaylater[index],
      //         showYear: showYearLabel,
      //       );
      //     },
      //     separatorBuilder: (_, i) => Gap(12.h),
      //     itemCount: controller.billPaylater.length)
    );
  }
}
