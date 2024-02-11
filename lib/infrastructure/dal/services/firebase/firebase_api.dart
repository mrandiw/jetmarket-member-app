import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jetmarket/infrastructure/dal/repository/notification_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/services/firebase/firebase_controller.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../domain/core/model/argument/chat_room_argument.dart';
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

void toDirectPagelink(String path, int pathId, String refId) {
  log("Terklik ke : $path");
  log("ID ke : $refId");

  switch (path) {
    case 'chat':
      Get.toNamed(Routes.DETAIL_CHAT,
          arguments: ChatRoomArgument(
            chatId: pathId,
            fromRole: 'customer',
          ));
    case 'order':
      Get.toNamed(Routes.DETAIL_ORDER, arguments: [pathId, null]);
    case 'withdraw':
      Get.toNamed(Routes.DETAIL_WITHDRAW, arguments: refId);
    case 'topup':
      Get.toNamed(Routes.DETAIL_TOPUP, arguments: refId);
    case 'loan-propose':
      Get.toNamed(Routes.DETAIL_PENGAJUAN_PINJAMAN, arguments: pathId);
    case 'loan-bill':
      Get.toNamed(Routes.DETAIL_TAGIHAN_BULANAN, arguments: pathId);
    case 'saving':
      Get.toNamed(Routes.DETAIL_MENABUNG, arguments: pathId);
    case 'referral':
      Get.toNamed(Routes.REFERRAL);
    case 'transaction':
      Get.toNamed(Routes.ORDER_LIST_TRANSACTION, arguments: refId);
    default:
      break;
  }
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
  log("DATA : ${message.data}");
  log("TITLE :${message.notification?.title}");
  log("BODY : ${message.notification?.body}");
  log("PAGELINK :${message.data['pagelink']}");
  List<String> parts = message.data['pagelink'].split('/');
  parts.removeAt(0);
  log("Parts : $parts");

  if (parts[0] == 'main') {
    AppPreference().clearOnSuccessPayment();
    Get.offAllNamed(Routes.MAIN_PAGES);
  } else if (parts[0] == 'payment_method') {
    AppPreference().removetrxId();
    Get.offAllNamed(Routes.PAYMENT_REGISTER);
  } else if (parts[0] == 'transaction') {
    Get.offNamed(Routes.ORDER_LIST_TRANSACTION,
        arguments: [parts[1], 'from-notification']);
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
  }

  openMessage(RemoteMessage? message) {
    updateUnreadNotification();
  }

  static Future<void> handleForegroundNotification(
    RemoteMessage message,
  ) async {
    settingShowNotification(message);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final tokenFcm = await _firebaseMessaging.getToken();
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
            String payloadString = details.payload ?? '';
            log("Payload : $payloadString");
            payloadString =
                payloadString.replaceAll('{', '').replaceAll('}', '');
            List<String> part = payloadString.split(RegExp(r',|:'));
            List<String> parts = part.last.trim().split('/');

            parts.removeAt(0);
            if (parts[0] == 'main' || parts[0] == 'payment_method') {
              if (parts[0] == 'main') {
                Get.offAllNamed(Routes.MAIN_PAGES);
              } else if (parts[0] == 'payment_method') {
                Get.offAllNamed(Routes.PAYMENT_REGISTER);
              } else if (parts[0] == 'transaction') {
                Get.offNamed(Routes.ORDER_LIST_TRANSACTION,
                    arguments: [parts[1], 'from-notification']);
              }
            } else if (parts[0] == 'withdraw' ||
                parts[0] == 'topup' ||
                parts[0] == 'transaction') {
              toDirectPagelink(parts[0], 0, parts[1]);
            } else if (parts[0] == 'loan' && parts[1] == 'bill' ||
                parts[0] == 'loan' && parts[1] == 'propose') {
              toDirectPagelink(
                  "${parts[0]}-${parts[1]}", int.parse(parts[2]), "");
            }
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
    FirebaseMessaging.onMessage.listen(handleForegroundNotification);
  }
}
