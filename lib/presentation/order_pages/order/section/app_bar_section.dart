import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/order_pages/order/controllers/order.controller.dart';
import '../../../../infrastructure/dal/repository/notification_repository_impl.dart';
import '../../../../infrastructure/dal/services/firebase/firebase_controller.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_text.dart';
import 'header_section.dart';

class AppBarDetailOrder extends StatelessWidget {
  final TabController tabController;
  final OrderController controller;
  final bool isScroll;

  const AppBarDetailOrder({
    super.key,
    required this.tabController,
    required this.controller,
    required this.isScroll,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return SliverAppBar(
        pinned: true,
        floating: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        expandedHeight:
            controller.waitingOrderCustomerLenght.value > 0 ? 230.h : 180.h,
        forceElevated: isScroll,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              Container(
                color: kWhite,
                height: 48.h,
                child: Row(
                  children: [
                    Gap(16.w),
                    Text('Daftar Pesanan', style: text16BlackSemiBold),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.NOTIFICATION),
                      child: GetBuilder<FirebaseController>(
                          init:
                              FirebaseController(NotificationRepositoryImpl()),
                          builder: (controller) {
                            return Badge.count(
                              count: controller.unreadCount,
                              backgroundColor: kPrimaryColor,
                              largeSize: 14,
                              textStyle:
                                  TextStyle(fontSize: 8.sp, color: kWhite),
                              isLabelVisible:
                                  controller.unreadCount > 0 ? true : false,
                              offset: const Offset(2, -2),
                              child: Icon(
                                Icons.notifications,
                                color: const Color(0xff333333).withOpacity(0.4),
                              ),
                            );
                          }),
                    ),
                    Gap(16.w),
                  ],
                ),
              ),
              Divider(
                color: kBorder,
                height: 0,
                thickness: 1,
              ),
              HeaderSection(controller: controller)
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(bottom: BorderSide(color: kDivider, width: 0.3)),
            ),
            child: TabBar(
              isScrollable: true,
              controller: tabController,
              labelStyle: text12PrimarySemiBold,
              indicatorColor: kSecondaryColor,
              labelColor: kSecondaryColor,
              unselectedLabelColor: kSofterGrey,
              indicatorSize: TabBarIndicatorSize.label,
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              tabs: controller.statusTabs.map((e) {
                return Tab(
                  text: e['name'],
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }
}
