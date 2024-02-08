import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/ewallet_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/waiting_payment_model.dart';
import 'package:jetmarket/presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/core/interfaces/payment_repository.dart';
import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../utils/app_preference/app_preferences.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

enum PaymentMethodeType { va, retail, qris, wallet }

class PaymentTopupSaldoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final EwalletRepository _ewalletRepository;
  final PaymentRepository _paymentRepository;

  PaymentTopupSaldoController(this._ewalletRepository, this._paymentRepository);
  int lenghTabs = 0;

  var screenStatus = ScreenStatus.initalize.obs;
  var methodeType = PaymentMethodeType.va;
  TutorialPaymentVaModel? tutorialPayment;
  TabController? tabController;

  late Timer timer;
  final countDuration = false.obs;
  final durationInSeconds = 0.obs;
  final formattedDuration = '00:00:00'.obs;

  WaitingPaymentModel? waitingPayment;

  List<String> assetsImageForQrisScreen = [
    'assets/images/ovo.png',
    'assets/images/gopay.png',
    'assets/images/shopeepay.png',
    'assets/images/linkaja.png',
    'assets/images/dana.png'
  ];

  Future<void> getWaitingPayment() async {
    screenStatus(ScreenStatus.loading);
    final response = await _ewalletRepository.getTransaction(Get.arguments);
    if (response.status == StatusResponse.success) {
      waitingPayment = response.result;
      log(response.path ?? 'null-path');

      update();
      startTimer(waitingPayment?.referenceId ?? '');
      if (waitingPayment?.channel?.type == 'EWALLET') {
        methodeType = PaymentMethodeType.wallet;
      } else if (waitingPayment?.channel?.type == 'OTC') {
        String? lowerCaseCode = waitingPayment?.channel?.code?.toLowerCase();
        getTutorial(lowerCaseCode ?? '');
        methodeType = PaymentMethodeType.retail;
      } else if (waitingPayment?.channel?.type == 'QR_CODE') {
        methodeType = PaymentMethodeType.qris;
      } else {
        String? lowerCaseCode = waitingPayment?.channel?.code?.toLowerCase();

        getTutorial(lowerCaseCode ?? '');
        methodeType = PaymentMethodeType.va;
      }
      update();
      Future.delayed(1.seconds, () {
        screenStatus(ScreenStatus.success);
      });
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void refreshEwalletPage() {
    Get.back();
    final controller = Get.find<EWalletController>();
    controller.getBalance();
    controller.pagingController.itemList?.clear();
    controller.getBalanceHistory(1);
  }

  getTutorial(String path) async {
    final response = await _paymentRepository.fetchDataFromJsonFile(path);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      tutorialPayment = response;
      lenghTabs = tutorialPayment?.tabs?.length ?? 0;
      tabController = TabController(length: lenghTabs, vsync: this);
      update();
    }
  }

  String assetImage(String path) {
    return "assets/images/$path.png";
  }

  void startTimer(String id) async {
    int? startTime = AppPreference().getCountDownPaymentTopupWallet(id);
    if (startTime != null) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      int elapsedTime = (currentTime - startTime) ~/ 1000;
      durationInSeconds.value = 86400 - elapsedTime;
      formattedDuration.value = _formatDuration(durationInSeconds.value);
      countDuration.value = true;
      if (durationInSeconds.value > 0) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (durationInSeconds.value > 0) {
            durationInSeconds.value--;
            formattedDuration.value = _formatDuration(durationInSeconds.value);
          } else {
            timer.cancel();
            countDuration.value = false;
            durationInSeconds.value = 86400;
            formattedDuration.value = '23:59:59';
          }
        });
      }
    } else {
      int newStartTime = DateTime.now().millisecondsSinceEpoch;
      AppPreference().saveCountDownPaymentTopupWallet(newStartTime, id);
      durationInSeconds.value = 86400;
      formattedDuration.value = '23:59:59';
      countDuration.value = true;

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (durationInSeconds.value > 0) {
          durationInSeconds.value--;
          formattedDuration.value = _formatDuration(durationInSeconds.value);
        } else {
          timer.cancel();
          countDuration.value = false;
          durationInSeconds.value = 86400;
          formattedDuration.value = '23:59:59';
        }
      });
    }
  }

  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int remainingSeconds = duration.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void copyVa(String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.vibrate();
  }

  void onTapQrCode(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<bool> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
      return true;
    } else {
      return false;
    }
  }

  void _handleMessage(RemoteMessage message) async {
    if (message.notification != null) {
      log(message.notification?.body ?? 'o');
    }
  }

  @override
  void onInit() {
    getWaitingPayment();
    setupInteractedMessage();
    super.onInit();
  }
}
