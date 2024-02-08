import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_history_model.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/controllers/koperasi.controller.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/widget/saving_history_item.dart';

import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key, required this.controller});

  final KoperasiController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppStyle.paddingAll16,
        sliver: PagedSliverList.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<SavingHistoryModel>(
              itemBuilder: (context, item, index) => SavingHistoryItem(
                index: index,
                data: item,
              ),
              newPageProgressIndicatorBuilder: InfinitiPage.progress,
              firstPageProgressIndicatorBuilder: InfinitiPage.progress,
              noItemsFoundIndicatorBuilder: (_) =>
                  InfinitiPage.empty(_, 'Riwayat'),
              firstPageErrorIndicatorBuilder: InfinitiPage.error,
            ),
            separatorBuilder: (_, i) => Gap(12.h)));
  }
}
