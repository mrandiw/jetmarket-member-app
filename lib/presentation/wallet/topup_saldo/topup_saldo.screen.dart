import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/topup_saldo.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/payment_methode.dart';

class TopupSaldoScreen extends GetView<TopupSaldoController> {
  const TopupSaldoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopUp,
      body: PaymentMethode(controller: controller),
      bottomNavigationBar: ButtonSection(
        controller: controller,
      ),
    );
  }
}
