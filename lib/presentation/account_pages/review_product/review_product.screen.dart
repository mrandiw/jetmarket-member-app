import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/review_product.controller.dart';
import 'section/app_bar_section.dart';
import 'section/list_order_section.dart';

class ReviewProductScreen extends GetView<ReviewProductController> {
  const ReviewProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (_, inBoxScrolled) {
              return [
                AppBarReviewProduct(
                  tabController: controller.tabController,
                  controller: controller,
                  isScroll: inBoxScrolled,
                ),
              ];
            },
            body: TabBarView(
                controller: controller.tabController,
                children: List.generate(
                    controller.statusTabs.length,
                    (index) => Obx(() {
                          if (!controller.loadingOnChangeTab.value) {
                            return ListOrderSection(
                                controller: controller, indexTab: index);
                          } else {
                            return SizedBox(
                              height: Get.height * 0.7,
                              child: const Center(
                                  child: CupertinoActivityIndicator(
                                color: kSoftGrey,
                              )),
                            );
                          }
                        })))),
      ),
    );
  }
}
