import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/order_pages/review_order/section/list_product_section.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/review_order.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';

class ReviewOrderScreen extends GetView<ReviewOrderController> {
  const ReviewOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(controller),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Widget successWidget(ReviewOrderController controller) {
    return Scaffold(
      appBar: appBarDetailOrderReview,
      backgroundColor: kWhite,
      body: ListProductSection(controller: controller),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
