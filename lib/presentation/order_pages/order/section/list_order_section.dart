import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/order_product_model.dart';
import 'package:jetmarket/presentation/order_pages/order/controllers/order.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';
import '../widget/order_card.dart';

class ListOrderSection extends StatelessWidget {
  const ListOrderSection({super.key, required this.controller});
  final OrderController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
            padding: AppStyle.paddingAll16,
            sliver: PagedSliverList.separated(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<OrderProductModel>(
                  itemBuilder: (context, item, index) => OrderCard(
                    data: item,
                    status:
                        controller.selectedStatusOrder['value'] ?? 'packaging',
                    onTap: () => controller.toDetailOrder(item.id ?? 0),
                    actionOrder: () => controller.actionOrder(item),
                    tracking: () => controller.toTrackingRefund(item.id ?? 0),
                  ),
                  newPageProgressIndicatorBuilder: InfinitiPage.progress,
                  firstPageProgressIndicatorBuilder: InfinitiPage.progress,
                  noItemsFoundIndicatorBuilder: (_) =>
                      InfinitiPage.empty(_, 'Order'),
                  firstPageErrorIndicatorBuilder: InfinitiPage.error,
                ),
                separatorBuilder: (_, i) => Gap(12.h))),
      ],
    );
  }
}
