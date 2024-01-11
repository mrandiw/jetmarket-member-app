import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/set_refund/controllers/set_refund.controller.dart';
import '../widget/product_item.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetRefundController>(builder: (controller) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return ProductItem(
            data: controller.setRefundModel?.refundItems?[index],
          );
        },
        separatorBuilder: (_, __) => Gap(8.h),
        itemCount: controller.setRefundModel?.refundItems?.length ?? 0,
      );
    });
  }
}
