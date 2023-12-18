import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/presentation/screens.dart';

import '../../../infrastructure/dal/services/firebase/firebase_controller.dart';

class MainPagesController extends GetxController {
  var selectedIndex = 0;
  void changeTabIndex(int index) {
    selectedIndex = index;
    update();
  }

  // Future<bool> setupInteractedMessage() async {
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     await updateUnreadNotification();
  //     _handleMessage(initialMessage);
  //     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // void _handleMessage(RemoteMessage message) async {
  //   if (message.notification != null) {
  //     log(message.notification?.body ?? 'o');
  //   }
  // }

  Future<void> updateUnreadNotification() async {
    print("Update on main");
    final controller =
        Get.put(FirebaseController(NotificationRepositoryImpl()));
    await controller.getUnreadNotification();
  }

  List<Widget> listPages = [
    const HomeScreen(),
    const OrderScreen(),
    const KoperasiScreen(),
    const EWalletScreen(),
    const AccountScreen()
  ];

  // @override
  // void onReady() {
  //   // setupInteractedMessage();
  //   super.onInit();
  // }

  @override
  void onInit() {
    updateUnreadNotification();
    super.onInit();
  }
}
