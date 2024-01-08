import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/review_order/controllers/review_order.controller.dart';
import 'package:jetmarket/presentation/order_pages/review_order/widget/product_review_item.dart';

class ListProductSection extends StatelessWidget {
  const ListProductSection({super.key, required this.controller});

  final ReviewOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: GetBuilder<ReviewOrderController>(builder: (controller) {
          return ListView.separated(
              itemBuilder: (_, index) => ProductReviewItem(
                    products: controller.productReview[index],
                    reviewTextLenght: controller.reviewTextLenght[index],
                    textController: controller.reviewController[index],
                    imagesReview: controller.imagesReview[index],
                    indexProduct: index,
                    listenForChange: (value) =>
                        controller.listenReviewText(value, index),
                    changeRating: (value) =>
                        controller.changeRating(value, index),
                    onTapCamera: () => controller.getImageCamera(
                        controller.productReview[index].name ?? '', index),
                    onTapGallery: () => controller.getImageGalery(
                        controller.productReview[index].name ?? '', index),
                    deleteImage: (value) =>
                        controller.deleteImageReview(index, value),
                  ),
              separatorBuilder: (_, i) => Gap(22.h),
              itemCount: controller.productReview.length);
        }));
  }
}
