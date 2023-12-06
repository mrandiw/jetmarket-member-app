import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/main_pages/controllers/main_pages.controller.dart';

import '../section/detail_payment.dart';

class CheckoutPaymentRetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController phoneController = TextEditingController();

  String paymentMethod = "";
  bool isPaymentReady = false;

  void numberPhone(String value) {
    if (value.isNotEmpty) {
      isPaymentReady = true;
    } else {
      isPaymentReady = false;
    }
    update();
  }

  void openDetailPayment() {
    CustomBottomSheet.show(child: const DetailPayment());
  }

  void toMerchenPage() {
    final mainController = Get.find<MainPagesController>();
    Get.offNamed(Routes.MAIN_PAGES);
    mainController.changeTabIndex(1);
  }

  void toPaymentSuccess() {
    final mainController = Get.find<MainPagesController>();
    Get.offNamedUntil(Routes.PAYMENT_SUCCESS_RETAIL,
        (route) => route.settings.name == Routes.MAIN_PAGES);
    mainController.changeTabIndex(1);
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    paymentMethod = Get.arguments['methode'];
    super.onInit();
  }
}
