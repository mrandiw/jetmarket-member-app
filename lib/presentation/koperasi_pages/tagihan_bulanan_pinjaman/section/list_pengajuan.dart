import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/presentation/koperasi_pages/tagihan_bulanan_pinjaman/controllers/tagihan_bulanan_pinjaman.controller.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';
import '../../../../domain/core/model/model_data/loan_bill_model.dart';
import '../widget/loan_item.dart';

class ListTagihanBulanan extends StatelessWidget {
  const ListTagihanBulanan({super.key, required this.controller});

  final TagihanBulananPinjamanController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppStyle.paddingAll16,
        sliver: PagedSliverList.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<LoanBillModel>(
              itemBuilder: (context, item, index) {
                final currentData =
                    controller.pagingController.itemList?[index];
                final previousData = index > 0
                    ? controller.pagingController.itemList![index - 1]
                    : null;
                final showYearLabel = previousData == null ||
                    currentData?.dueAt?.getYear != previousData.dueAt?.getYear;

                return ItemBill(
                  data: item,
                  showYear: showYearLabel,
                );
              },
              newPageProgressIndicatorBuilder: InfinitiPage.progress,
              firstPageProgressIndicatorBuilder: InfinitiPage.progress,
              noItemsFoundIndicatorBuilder: (_) =>
                  InfinitiPage.empty(_, 'Tagihan Pinjaman'),
              firstPageErrorIndicatorBuilder: InfinitiPage.error,
            ),
            separatorBuilder: (_, i) => Gap(12.h)));
  }
}
