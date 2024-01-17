import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/waiting_payment_model.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/controllers/koperasi.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/core/interfaces/payment_repository.dart';
import '../../../../domain/core/interfaces/saving_repository.dart';
import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/app_preference/app_preferences.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

enum PaymentMethodeType { va, retail, qris, wallet }

class TabunganPaymentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final SavingRepository _savingRepository;
  final PaymentRepository _paymentRepository;

  TabunganPaymentController(this._savingRepository, this._paymentRepository);
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
    'assets/images/OVO.png',
    'assets/images/gopay.png',
    'assets/images/SHOPEEPAY.png',
    'assets/images/LINKAJA.png',
    'assets/images/DANA.png'
  ];

  Future<void> getWaitingPayment() async {
    screenStatus(ScreenStatus.loading);
    final response = await _savingRepository.waitingPayment();
    if (response.status == StatusResponse.success) {
      waitingPayment = response.result;
      update();
      if (response.result?.id == null) {
        Get.offNamed(Routes.TABUNGAN);
      } else {
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
      }
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void refreshSavingPage() {
    Get.back();
    Get.back();
    final controller = Get.find<KoperasiController>();
    controller.getSavingTotal();
    controller.pagingController.refresh();
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
    int? startTime = AppPreference().getCountDownSavingPayment(id);
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
      AppPreference().saveCountDownSavingPayment(newStartTime, id);
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

  checkCountdown() async {
    int? startTime = AppPreference().getCountDown();

    if (startTime != null) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      int elapsed = currentTime - startTime;
      int remainingTime = (24 * 60 * 60 * 1000) - elapsed;
      Duration duration = Duration(milliseconds: remainingTime);

      formattedDuration.value =
          '${duration.inHours.remainder(24).toString().padLeft(2, '0')}:${(duration.inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
    } else {}
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
