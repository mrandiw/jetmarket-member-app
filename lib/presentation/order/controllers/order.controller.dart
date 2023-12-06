import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  var currentIndexTab = 0.obs;
  List<String> tabs = [
    'Sedang Dikemas',
    'Dalam Pengiriman',
    "Selesai",
    "Dibatalkan",
    "Pengembalian"
  ];

  void toWaitingPayment() {
    Get.toNamed(Routes.WAITING_PAYMENT);
  }

  void toDetailOrder(String status) {
    Get.toNamed(Routes.DETAIL_ORDER, arguments: {'status': status});
  }

  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      currentIndexTab.value = tabController.index;
    });
    super.onInit();
  }
}
