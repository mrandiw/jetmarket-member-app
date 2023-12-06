import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/detail_store/section/app_bar_section.dart';
import 'package:jetmarket/presentation/detail_store/section/category_section.dart';

import '../../infrastructure/theme/app_colors.dart';
import 'controllers/detail_store.controller.dart';
import 'section/product_section.dart';

class DetailStoreScreen extends GetView<DetailStoreController> {
  const DetailStoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      color: kSecondaryColor,
      onRefresh: () => controller.refreshData(),
      child: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (_, inBoxScrolled) {
              return [
                AppBarDetailStore(
                  tabController: controller.tabController,
                  controller: controller,
                  isScroll: inBoxScrolled,
                ),
              ];
            },
            body: TabBarView(
                controller: controller.tabController,
                children: const [ProductSection(), CategorySection()])),
      ),
    ));
  }
}
