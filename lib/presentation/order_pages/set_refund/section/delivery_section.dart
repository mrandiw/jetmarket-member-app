import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/set_refund/controllers/set_refund.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import '../widget/delivery_item.dart';

class DeliverySection extends StatelessWidget {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetRefundController>(builder: (controller) {
      return Column(children: [
        DeliveryItem(
          data: controller.setRefundModel?.services,
        ),
        Gap(16.h),
        Visibility(
          visible: controller.selectedIndexService != null &&
              controller.selectedIndexPackage != null,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: AppStyle.borderRadius8All,
            ),
            color: kBorder,
            elevation: 0,
            child: ListTile(
              contentPadding: AppStyle.paddingSide12,
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text(
                '${controller.setRefundModel?.services?[controller.selectedIndexService ?? 0].packets?[controller.selectedIndexPackage ?? 0].name ?? ''} ${controller.setRefundModel?.services?[controller.selectedIndexService ?? 0].packets?[controller.selectedIndexPackage ?? 0].rate.toString().toIdrFormat ?? ''}',
                style: text12BlackRegular,
              ),
              subtitle: Text(
                controller
                        .setRefundModel
                        ?.services?[controller.selectedIndexService ?? 0]
                        .packets?[controller.selectedIndexPackage ?? 0]
                        .duration ??
                    '',
                style: text12HintRegular,
              ),
            ),
          ),
        ),
      ]);
    });
  }
}
