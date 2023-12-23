import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/home/section/app_bar_section.dart';
import 'package:jetmarket/presentation/home_pages/home/section/banner_section.dart';
import 'controllers/home.controller.dart';
import 'section/category_section.dart';
import 'section/product_popular_onpage.dart';
import 'section/product_popular_section.dart';
import 'section/product_section.dart';
import 'section/search_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isHomeScreen.value
          ? _homePageSection()
          : _popularPage();
    });
  }

  Widget _homePageSection() {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
          appBar: appBarHome,
          backgroundColor: kWhite,
          body: SafeArea(
              child: RefreshIndicator(
                  color: kPrimaryColor,
                  onRefresh: () async {
                    await Future.delayed(1.seconds, () {
                      controller.refreshData();
                      controller.pagingController.refresh();
                    });
                  },
                  child: CustomScrollView(
                    slivers: [
                      SearchSection(controller: controller),
                      const BannerSection(),
                      const CategorySection(),
                      ProductPopularSection(controller: controller),
                      ProductSection(controller: controller),
                      SliverToBoxAdapter(child: Gap(16.h)),
                    ],
                  )))),
    );
  }

  Widget _popularPage() {
    return WillPopScope(
      onWillPop: () async {
        controller.seeAllPopular();
        return false;
      },
      child: Scaffold(
          appBar: appBarHome,
          backgroundColor: kWhite,
          body: SafeArea(
              child: RefreshIndicator(
                  color: kPrimaryColor,
                  onRefresh: () async {
                    await Future.delayed(1.seconds, () {
                      controller.pagingPopularController.refresh();
                    });
                  },
                  child: CustomScrollView(
                    slivers: [
                      SearchSection(controller: controller),
                      ProductPopularOnPageSection(controller: controller),
                      SliverToBoxAdapter(child: Gap(16.h)),
                    ],
                  )))),
    );
  }
}
