import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/set_refund.controller.dart';
import 'section/address_section.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/delivery_section.dart';
import 'section/product_section.dart';

class SetRefundScreen extends GetView<SetRefundController> {
  const SetRefundScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(controller),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Scaffold successWidget(SetRefundController controller) {
    return Scaffold(
      appBar: appBarSetRefund,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: const [AddressSection(), ProductSection(), DeliverySection()],
      ),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
