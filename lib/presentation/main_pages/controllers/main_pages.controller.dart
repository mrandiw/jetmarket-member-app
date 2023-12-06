import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/screens.dart';

class MainPagesController extends GetxController {
  var selectedIndex = 0;
  void changeTabIndex(int index) {
    selectedIndex = index;
    update();
  }

  List<Widget> listPages = [
    const HomeScreen(),
    const OrderScreen(),
    const KoperasiScreen(),
    const EWalletScreen(),
    const AccountScreen()
  ];
}
