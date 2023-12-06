import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/order/section/app_bar_section.dart';
import 'package:jetmarket/presentation/order/section/being_packaged.dart';
import 'package:jetmarket/presentation/order/section/cencel_order.dart';
import 'package:jetmarket/presentation/order/section/done_order.dart';
import 'package:jetmarket/presentation/order/section/on_delivery.dart';
import 'package:jetmarket/presentation/order/section/return_order.dart';

import 'controllers/order.controller.dart';
import 'section/app_bar_section.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                children: const [
                  BeingPackaged(),
                  OnDelivery(),
                  DoneOrder(),
                  CancelOrder(),
                  ReturnOrder()
                ])),
      ),
    );
  }
}
