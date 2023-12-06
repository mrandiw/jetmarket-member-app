import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaraBayarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}
