import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/services/firebase/firebase_controller.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/home/section/app_bar_section.dart';
import 'package:jetmarket/presentation/home_pages/home/section/banner_section.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'controllers/home.controller.dart';
import 'section/category_section.dart';
import 'section/product_popular_onpage.dart';
import 'section/product_promo_onpage.dart';
import 'section/product_promo_section.dart';
import 'section/product_popular_section.dart';
import 'section/product_section.dart';
import 'section/search_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isHomeScreen.value ? _homePageSection() : _seeAllPage();
    });
  }

  Widget _homePageSection() {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
          appBar: appBarHome,
          backgroundColor: kWhite,
          body: SafeArea(
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: controller.homeRefreshController,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoading,
                  header: const WaterDropHeader(
                    waterDropColor: kPrimaryColor,
                    complete: SizedBox.shrink(),
                    refresh: CupertinoActivityIndicator(
                      color: kSoftGrey,
                    ),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SearchSection(controller: controller),
                      const BannerSection(),
                      const CategorySection(),
                      ProductPromoSection(controller: controller),
                      ProductPopularSection(controller: controller),
                      ProductSection(controller: controller),
                      SliverToBoxAdapter(child: Gap(16.h)),
                    ],
                  )))),
    );
  }

  Widget _seeAllPage() {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.backToHomeFromSeeAll();
        return false;
      },
      child: Scaffold(
          appBar: _seeAllAppBar(),
          backgroundColor: kWhite,
          body: SafeArea(
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: controller.seeAllRefreshController,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoading,
                  header: const WaterDropHeader(
                    waterDropColor: kPrimaryColor,
                    complete: SizedBox.shrink(),
                    refresh: CupertinoActivityIndicator(
                      color: kSoftGrey,
                    ),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SearchSection(controller: controller),
                      controller.seeAllProductType == SeeAllProductType.popular
                          ? ProductPopularOnPageSection(
                              controller: controller,
                            )
                          : ProductPromoOnPageSection(
                              controller: controller,
                            ),
                      SliverToBoxAdapter(child: Gap(16.h)),
                    ],
                  )))),
    );
  }

  AppBar _seeAllAppBar() {
    return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      toolbarHeight: 52.hr,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          controller.backToHomeFromSeeAll();
        },
      ),
      title: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.seeAllProductType == SeeAllProductType.popular 
                ? 'Produk Terlaris' 
                : 'Produk Promo', 
                style: text14BlackMedium),
          ],
        );
      }),
      actions: [
        GetBuilder<HomeController>(builder: (homeController) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.CHATS),
            child: FutureBuilder(
              future: homeController.getUnreadChat(),
              builder: (context, snapshot) {
                return Badge.count(
                  count: snapshot.hasData ? snapshot.data ?? 0 : 0,
                  isLabelVisible: (snapshot.data ?? 0) > 0 ? true : false,
                  child: SvgPicture.asset(chatFill),
                );
              },
            ),
          );
        }),
        Gap(10.w),
        GetBuilder<HomeController>(builder: (homeController) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.CART),
            child: FutureBuilder(
              future: homeController.getCountChart(),
              builder: (context, snapshot) {
                return Badge.count(
                  count: snapshot.hasData ? snapshot.data ?? 0 : 0,
                  isLabelVisible: (snapshot.data ?? 0) > 0 ? true : false,
                  child: SvgPicture.asset(
                    cart,
                    // height: 14.wr,
                    // fit: BoxFit.fitHeight,
                  ),
                );
              },
            ),
          );
        }),
        Gap(10.w),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.NOTIFICATION),
          child: GetBuilder<FirebaseController>(
              init: FirebaseController(NotificationRepositoryImpl()),
              builder: (controller) {
                return Badge.count(
                  count: controller.unreadCount,
                  backgroundColor: kPrimaryColor,
                  largeSize: 14,
                  textStyle: TextStyle(fontSize: 8.sp, color: kWhite),
                  isLabelVisible: controller.unreadCount > 0 ? true : false,
                  offset: const Offset(2, -2),
                  child: Icon(
                    Icons.notifications,
                    color: const Color(0xff333333).withOpacity(0.4),
                  ),
                );
              }),
        ),
        Gap(16.w)
      ],
    );
  }
}
