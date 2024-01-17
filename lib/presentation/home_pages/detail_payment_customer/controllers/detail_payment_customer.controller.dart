import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/core/interfaces/payment_repository.dart';
import '../../../../domain/core/model/argument/payment_methode_argument.dart';
import '../../../../domain/core/model/model_data/payment_customer_model.dart';
import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/app_preference/app_preferences.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

enum PaymentMethodeType { va, retail, qris, wallet }

class DetailPaymentCustomerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PaymentRepository _paymentRepository;

  DetailPaymentCustomerController(this._paymentRepository);
  int lenghTabs = 0;
  TextEditingController numberController = TextEditingController();
  var screenStatus = (ScreenStatus.initalize).obs;
  var methodeType = PaymentMethodeType.va;
  PaymentMethodeArgument? argument;
  PaymentCustomerModel? paymentCustomer;
  TutorialPaymentVaModel? tutorialPayment;
  TabController? tabController;

  late Timer timer;
  final countDuration = false.obs;
  final durationInSeconds = 0.obs;
  final formattedDuration = '00:00:00'.obs;

  List<String> assetsImageForQrisScreen = [
    'assets/images/OVO.png',
    'assets/images/gopay.png',
    'assets/images/SHOPEEPAY.png',
    'assets/images/LINKAJA.png',
    'assets/images/DANA.png'
  ];

  Future<void> getPaymentCustomerOnReister() async {
    screenStatus(ScreenStatus.loading);
    paymentCustomer = argument?.data;
    if (paymentCustomer?.channel?.type == 'EWALLET') {
      methodeType = PaymentMethodeType.wallet;
    } else if (paymentCustomer?.channel?.type == 'OTC') {
      String? lowerCaseCode = paymentCustomer?.channel?.code?.toLowerCase();
      getTutorial(lowerCaseCode ?? '');
      methodeType = PaymentMethodeType.retail;
    } else if (paymentCustomer?.channel?.type == 'QR_CODE') {
      methodeType = PaymentMethodeType.qris;
    } else {
      String? lowerCaseCode = paymentCustomer?.channel?.code?.toLowerCase();

      getTutorial(lowerCaseCode ?? '');
      methodeType = PaymentMethodeType.va;
    }
    update();
    Future.delayed(1.seconds, () {
      screenStatus(ScreenStatus.success);
    });
  }

  Future<void> getPaymentCustomer(int id) async {
    screenStatus(ScreenStatus.loading);
    final response = await _paymentRepository.getPaymentCustomer(id);
    if (response.status == StatusResponse.success) {
      paymentCustomer = response.result;
      update();
      if (response.result?.status == "SUCCEEDED") {
      } else if (response.result?.status == 'REQUIRES_ACTION') {
        if (response.result?.channel?.type == 'EWALLET') {
          methodeType = PaymentMethodeType.wallet;
        } else if (response.result?.channel?.type == 'OTC') {
          getTutorial(response.result?.channel?.code ?? '');
          methodeType = PaymentMethodeType.retail;
        } else if (response.result?.channel?.type == 'QR_CODE') {
          methodeType = PaymentMethodeType.qris;
        } else {
          String? lowerCaseCode = response.result?.channel?.code?.toLowerCase();
          getTutorial(lowerCaseCode ?? '');
          methodeType = PaymentMethodeType.va;
        }
        update();
        Future.delayed(1.seconds, () {
          screenStatus(ScreenStatus.success);
        });
      } else {
        Get.offAllNamed(Routes.PAYMENT_REGISTER);
      }
    } else {
      screenStatus(ScreenStatus.failed);
    }
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

  void startTimer() async {
    int? startTime = AppPreference().getCountDown();
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
      AppPreference().saveCountDown(newStartTime);
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

  void toLogin() {
    Get.offNamed(Routes.LOGIN);
  }

  setArgument() {
    argument = Get.arguments;
    if (argument?.status == "waiting") {
      getPaymentCustomer(argument?.trxId ?? 0);
    } else {
      getPaymentCustomerOnReister();
    }
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

  @override
  void onInit() {
    // setScreen();
    startTimer();
    setArgument();
    // getPaymentCustomerOnReister();

    super.onInit();
  }
}
