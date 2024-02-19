import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/checkout_payment_retail.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';
import 'widget/methode_sreen_state.dart';

class CheckoutPaymentRetailScreen
    extends GetView<CheckoutPaymentRetailController> {
  const CheckoutPaymentRetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPaymentRetail,
      body: MethodeScreenState(methode: controller.paymentMethod),
      bottomNavigationBar: controller.paymentMethod == "bank" ||
              controller.paymentMethod == "retail"
          ? FooterSection(
              controller: controller,
            )
          : const SizedBox.shrink(),
    );
  }
}
