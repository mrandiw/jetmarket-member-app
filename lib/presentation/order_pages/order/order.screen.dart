import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/order_pages/order/section/app_bar_section.dart';
import 'controllers/order.controller.dart';
import 'section/list_order_section.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          notificationPredicate: (notification) {
            if (notification is OverscrollNotification || Platform.isIOS) {
              return notification.depth == 2;
            }
            return notification.depth == 0;
          },
          color: kPrimaryColor,
          onRefresh: () async {
            await Future.delayed(1.seconds, () {
              controller.refreshData();
            });
          },
          child: NestedScrollView(
              headerSliverBuilder: (_, inBoxScrolled) {
                return [
                  AppBarDetailOrder(
                    tabController: controller.tabController,
                    controller: controller,
                    isScroll: inBoxScrolled,
                  ),
                ];
              },
              body: TabBarView(
                  controller: controller.tabController,
                  children: List.generate(controller.statusTabs.length,
                      (index) => ListOrderSection(controller: controller)))),
        ),
      ),
    );
  }
}
