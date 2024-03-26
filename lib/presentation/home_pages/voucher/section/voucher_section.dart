import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/vouchers.dart';
import 'package:jetmarket/presentation/home_pages/voucher/widget/voucher_item.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/voucher.controller.dart';

class VoucherSection extends StatelessWidget {
  const VoucherSection({super.key, required this.controller});
  final VoucherController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppStyle.paddingAll16,
        sliver: PagedSliverList.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Vouchers>(
              itemBuilder: (context, item, index) => VoucherItem(
                index: index,
                data: item,
                onTap: () => controller.selectVoucher(index),
                enable: (item.min ?? 0) <= Get.arguments,
              ),
              newPageProgressIndicatorBuilder: InfinitiPage.progress,
              firstPageProgressIndicatorBuilder: InfinitiPage.progress,
              noItemsFoundIndicatorBuilder: (_) =>
                  InfinitiPage.empty(_, 'Voucher'),
              firstPageErrorIndicatorBuilder: InfinitiPage.error,
            ),
            separatorBuilder: (_, i) => Gap(12.h)));
  }
}
