import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/order_product_model.dart';
import 'package:jetmarket/presentation/account_pages/review_product/widget/order_card.dart';
import 'package:jetmarket/presentation/order_pages/review_order/controllers/review_order.controller.dart';

class ListProductShowSection extends StatelessWidget {
  const ListProductShowSection({super.key, required this.controller});

  final ReviewOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: GetBuilder<ReviewOrderController>(builder: (controller) {
          return ListView.separated(
              itemBuilder: (_, index) {
                final item = controller.productReview[index];

                final data = OrderProductModel(
                  id: item.id,
                  orderRefId: '',
                  image: item.image,
                  name: item.name,
                  price: item.price,
                  quantity: item.quantity,
                  review: item.review,
                  status: '',
                  totalPrice: 0,
                  totalProduct: 0,
                );

                return OrderCard(
                  data: data,
                  status: 'reviewed',
                  actionOrder: () {},
                );
              },
              separatorBuilder: (_, i) => Gap(22.h),
              itemCount: controller.productReview.length);
        }));
  }
}
