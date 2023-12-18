import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/app_bar_section.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/tutorial_payment.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/section/va_payment.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/payment_topup_saldo.controller.dart';

class PaymentTopupSaldoScreen extends GetView<PaymentTopupSaldoController> {
  const PaymentTopupSaldoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarTopUpPayment,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: const [VaPayment(), TutorialPayment()],
        ));
  }
}
