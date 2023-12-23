import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/app_bar_section.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/tutorial_payment.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/va_payment.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/payment_topup_saldo.controller.dart';
import 'section/button_section.dart';

class PaymentTopupSaldoScreen extends GetView<PaymentTopupSaldoController> {
  const PaymentTopupSaldoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTopUpPayment,
      backgroundColor: kWhite,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: [VaPayment(controller: controller), const TutorialPayment()],
      ),
      bottomNavigationBar: const ButtonSection(),
    );
  }
}
