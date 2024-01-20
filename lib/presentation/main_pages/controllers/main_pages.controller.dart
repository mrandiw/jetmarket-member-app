import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/presentation/screens.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../infrastructure/dal/services/firebase/firebase_controller.dart';
import '../../../utils/assets/assets_svg.dart';
import 'item_bar_model.dart';

class MainPagesController extends GetxController {
  var selectedIndex = 0;
  bool isEmployee = true;
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
    final controller =
        Get.put(FirebaseController(NotificationRepositoryImpl()));
    await controller.getUnreadNotification();
  }

  List<Widget> get listPages {
    if (isEmployee) {
      return [
        const HomeScreen(),
        const OrderScreen(),
        const KoperasiScreen(),
        const EWalletScreen(),
        const AccountScreen(),
      ];
    } else {
      return [
        const HomeScreen(),
        const OrderScreen(),
        const EWalletScreen(),
        const AccountScreen(),
      ];
    }
  }

  List<ItemBarModel> get listItemBar {
    if (isEmployee) {
      return [
        ItemBarModel(
          label: "Home",
          icon: home,
          iconFill: homeFill,
        ),
        ItemBarModel(
          label: "Pesanan",
          icon: pesanan,
          iconFill: pesananFill,
        ),
        ItemBarModel(
          label: "Koperasi",
          icon: koperasi,
          iconFill: koperasiFill,
        ),
        ItemBarModel(
          label: "E-Wallet",
          icon: wallet,
          iconFill: walletFill,
        ),
        ItemBarModel(
          label: "Akun",
          icon: akun,
          iconFill: akunFill,
        )
      ];
    } else {
      return [
        ItemBarModel(
          label: "Home",
          icon: home,
          iconFill: homeFill,
        ),
        ItemBarModel(
          label: "Pesanan",
          icon: pesanan,
          iconFill: pesananFill,
        ),
        ItemBarModel(
          label: "E-Wallet",
          icon: wallet,
          iconFill: walletFill,
        ),
        ItemBarModel(
          label: "Akun",
          icon: akun,
          iconFill: akunFill,
        )
      ];
    }
  }
  // @override
  // void onReady() {
  //   // setupInteractedMessage();
  //   super.onInit();
  // }

  setEmploye() {
    isEmployee = AppPreference().getUserData()?.user?.isEmployee ?? false;
    update();
  }

  @override
  void onInit() {
    setEmploye();
    updateUnreadNotification();
    super.onInit();
  }
}
