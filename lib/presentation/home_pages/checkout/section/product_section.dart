import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../domain/core/model/model_data/cart_product.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../widget/product_item.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingSide16,
      child: GetBuilder<CheckoutController>(builder: (controller) {
        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              var data = controller.productCart[index];
              if (index > 0 &&
                  data.sellerId == controller.productCart[index - 1].sellerId) {
                return ProductItem(
                    data: data,
                    increment: () => controller.incrementProduct(
                        index, data.id ?? 0, data.qty ?? 0),
                    decrement: () => controller.decrementProduct(
                        index, data.id ?? 0, data.qty ?? 0));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(index != 0 ? 16.h : 0),
                    Text(data.sellerName ?? '', style: text12BlackRegular),
                    Gap(8.h),
                    Divider(
                      color: kBorder,
                      thickness: 1,
                      height: 0,
                    ),
                    Gap(8.h),
                    ProductItem(
                        data: data,
                        increment: () => controller.incrementProduct(
                            index, data.id ?? 0, data.qty ?? 0),
                        decrement: () => controller.decrementProduct(
                            index, data.id ?? 0, data.qty ?? 0)),
                  ],
                );
              }
            },
            separatorBuilder: (_, i) => Gap(8.h),
            itemCount: controller.productCart.length);
      }),
    );
  }
}
