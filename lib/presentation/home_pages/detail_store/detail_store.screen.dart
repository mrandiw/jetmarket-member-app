import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/parent_scaffold.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/section/app_bar_section.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/section/category_section.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/detail_store.controller.dart';
import 'section/product_section.dart';

class DetailStoreScreen extends GetView<DetailStoreController> {
  const DetailStoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onSuccess: _succesPage(),
        status: controller.screenStatus.value));
  }

  Widget _succesPage() {
    return WillPopScope(
      onWillPop: () async {
        controller.backToDetailProduct();
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(1.seconds, () {
              controller.refreshData();
              controller.pagingController.refresh();
            });
          },
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
                children: [
                  ProductSection(controller: controller),
                  CategorySection(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
