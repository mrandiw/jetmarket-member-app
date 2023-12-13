import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReferralController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> tabs = ['History', 'List Akun'];

  var currentIndexTab = 0.obs;

  void copyVa(String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.vibrate();
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentIndexTab.value = tabController.index;
    });
    super.onInit();
  }
}
