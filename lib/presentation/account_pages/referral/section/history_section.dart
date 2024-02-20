import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/refferal_model.dart';
import 'package:jetmarket/presentation/account_pages/referral/controllers/referral.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';
import '../widget/item_history.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key, required this.controller});

  final ReferralController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppStyle.paddingAll16.copyWith(top: 0, bottom: 26.h),
      sliver: PagedSliverList.separated(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<RefferalModel>(
            itemBuilder: (context, item, index) => ItemHistory(
              data: item,
            ),
            newPageProgressIndicatorBuilder: InfinitiPage.progress,
            firstPageProgressIndicatorBuilder: InfinitiPage.progress,
            noItemsFoundIndicatorBuilder: (_) =>
                InfinitiPage.empty(_, 'Riwayat'),
            firstPageErrorIndicatorBuilder: InfinitiPage.error,
          ),
          separatorBuilder: (_, i) => Gap(6.h)),
    );
  }
}
