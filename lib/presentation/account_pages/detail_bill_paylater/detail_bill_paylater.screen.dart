import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/detail_bill_paylater.controller.dart';
import 'section/app_bar_section.dart';
import 'section/detail_product.dart';
import 'section/footer_section.dart';
import 'section/info_delivery.dart';
import 'section/info_order_section.dart';
import 'section/payment_methode.dart';

class DetailBillPaylaterScreen extends GetView<DetailBillPaylaterController> {
  const DetailBillPaylaterScreen({Key? key}) : super(key: key);
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

  Widget successWidget(DetailBillPaylaterController controller) {
    return Scaffold(
      appBar: appBarDetailBil,
      body: ListView(
        children: [
          const InfoOrderSection(),
          InfoDelivery(controller: controller),
          DetailProduct(controller: controller),
          PaymentMethode(controller: controller)
        ],
      ),
      bottomNavigationBar: FooterSection(
        controller: controller,
      ),
    );
  }
}
