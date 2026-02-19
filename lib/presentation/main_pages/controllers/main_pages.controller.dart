import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_update_version.dart';
import 'package:jetmarket/infrastructure/dal/repository/app_version_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/presentation/screens.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../infrastructure/dal/services/firebase/firebase_controller.dart';
import '../../../utils/assets/assets_svg.dart';
import '../../../utils/global/constant.dart';
import 'item_bar_model.dart';

class MainPagesController extends GetxController {
  final _appVersionRepository = AppVersionRepositoryImpl();
  late StreamSubscription sub;
  var selectedIndex = 0;
  bool isEmployees = false;
  String versionApp = '1.0.0'; // Will be set dynamically in onInit

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      versionApp = packageInfo.version;
      log('App version loaded: $versionApp');
    } catch (e) {
      log('Error loading app version: $e');
    }
  }

  void changeTabIndex(int index) {
    selectedIndex = index;
    update();
  }

  Future<bool> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await updateUnreadNotification();
      _handleMessage(initialMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
      return true;
    } else {
      return false;
    }
  }

  void _handleMessage(RemoteMessage message) async {
    if (message.notification != null) {
      log("${message.data}");
      log("${message.data['pagelink']}");
      log(message.notification?.body ?? 'o');
    }
  }

  Future<void> updateUnreadNotification() async {
    final controller =
        Get.put(FirebaseController(NotificationRepositoryImpl()));
    await controller.getUnreadNotification();
  }

  List<Widget> get listPageIsEmploye {
    return [
      const HomeScreen(),
      const OrderScreen(),
      const KoperasiScreen(),
      const EWalletScreen(),
      const AccountScreen(),
    ];
  }

  List<Widget> get listPageNotIsEmploye {
    return [
      const HomeScreen(),
      const OrderScreen(),
      const EWalletScreen(),
      const AccountScreen(),
    ];
  }

  List<Widget> get listPages {
    if (isEmployees) {
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
    if (isEmployees) {
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
          label: "Mitra",
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

  setEmploye() {
    isEmployees = isEmployee;
    update();
  }

  rebuildController() {}

  Future<void> checkVersionApp() async {
    final response = await _appVersionRepository.getAppVersion();
    if (response.status == StatusResponse.success) {
      String latestVersion = response.result!.version ?? versionApp;
      if (isVersionHigher(versionApp, latestVersion)) {
        if (!Get.isDialogOpen!) {
          const playStoreUrl =
              'https://play.google.com/store/apps/details?id=com.jetmarket.customer';
          AppDialogUpdateVersion.show(
            title: 'Update Baru Tersedia',
            message: response.result!.note ??
                'Versi terbaru aplikasi sudah tersedia. Yuk, update sekarang untuk pengalaman belanja yang lebih baik!',
            playStoreUrl: playStoreUrl,
            barrierDismissible: false,
            onPressed: () {
              launchURL(playStoreUrl);
            },
          );
        }
      }
    }
  }

  bool isVersionHigher(String currentVersion, String latestVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> latest = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < latest.length; i++) {
      if (i >= current.length || latest[i] > current[i]) {
        return true;
      } else if (latest[i] < current[i]) {
        return false;
      }
    }
    return false;
  }

  Future<void> launchURL(String uri) async {
    final Uri url = Uri.parse(uri);

    // Check if the URL can be launched
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void onInit() {
    _initAsync();
    super.onInit();
  }

  Future<void> _initAsync() async {
    await _loadAppVersion();
    checkVersionApp();
    setEmploye();
    updateUnreadNotification();
    setupInteractedMessage();
  }
}
