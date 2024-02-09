import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/services/firebase/firebase_controller.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../utils/global/constant.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log(message.notification?.title ?? '');
  log(message.notification?.body ?? '');
  log("Data : ${message.data}");
  updateUnreadNotification();
}

Future<void> updateUnreadNotification() async {
  final controller = Get.put(FirebaseController(NotificationRepositoryImpl()));
  await controller.getUnreadNotification();
}

void toMainPage() {
  Get.offAllNamed(Routes.MAIN_PAGES);
}

settingShowNotification(RemoteMessage message) async {
  var androidDetails = const AndroidNotificationDetails(
    'high_importance_channel',
    'high_importance_channel_name',
    priority: Priority.high,
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );
  var platformDetails = NotificationDetails(android: androidDetails);

  // Tampilkan notifikasi
  await FirebaseApi._local.show(
    -2,
    message.notification?.title?.capitalizeFirst,
    message.notification?.body?.capitalizeFirst,
    platformDetails,
    payload: message.data.toString(),
  );
  if (message.data['pagelink'] == '/main') {
    AppPreference().cleanCurrentPage();
    Get.offAllNamed(Routes.MAIN_PAGES);
  } else {
    await updateUnreadNotification();
  }
}

class FirebaseApi {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseApi._firebaseMessaging;
  static FlutterLocalNotificationsPlugin get local => FirebaseApi._local;

  final box = GetStorage();
  bool appForeground = true;

  handleMessage(RemoteMessage? message) {
    if (message != null) return;
    log("${message?.notification?.title}");
    log("${message?.data}");
    log("${message?.data['pagelink']}");
    log(message?.notification?.body ?? 'o');
    try {
      if (message?.notification != null) {
        if (message?.data['pagelink'] == '/main') {
          AppPreference().cleanCurrentPage();
          Get.offAllNamed(Routes.MAIN_PAGES);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  openMessage(RemoteMessage? message) {
    updateUnreadNotification();
    log("---------OPEN----------");
    final data = message?.data;
    if (data != null) {
      log(message?.data.toString() ?? '');
      log(message?.data['pagelink']);
      log(message?.notification?.body ?? 'o');
      // Validasi tipe data

      if (message?.data['pagelink'] == '/main') {
        AppPreference().cleanCurrentPage();
        Get.offAllNamed(Routes.MAIN_PAGES);
      }
    } else {
      // Tampilkan Snackbar jika data tidak ditemukan
      Get.showSnackbar(GetSnackBar(
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        backgroundColor: Colors.red,
        message: "Data tidak valid",
        duration: 1.seconds,
        snackPosition: SnackPosition.TOP,
      ));
    }
  }

  static Future<void> handleForegroundNotification(
    RemoteMessage message,
  ) async {
    // Konfigurasi notifikasi
    settingShowNotification(message);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final tokenFcm = await _firebaseMessaging.getToken();
    // await FirebaseMessaging.instance.subscribeToTopic("topic");
    fcmToken = tokenFcm ?? '';
    box.write('fcm_token', tokenFcm);
    log("TOKEN : $tokenFcm");
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializeSetting = InitializationSettings(android: androidInitialize);
    _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    _local.initialize(
      initializeSetting,
      onDidReceiveNotificationResponse: (details) {
        try {
          if (details.payload != null) {
            log("Init FCM");
            log("Payload : ${details.payload}");
          } else {}
        } catch (e) {
          throw Exception(e);
        }
        return;
      },
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, sound: true, badge: true);

    await _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(openMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    // if (appForeground == true) {
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

    //   });
    // } else {
    //   FirebaseMessaging.onMessage.listen(handleForegroundNotification);
    // }
    FirebaseMessaging.onMessage.listen(handleForegroundNotification);
  }
}
