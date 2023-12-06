import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/choice_payment/section/app_bar_section.dart';
import 'package:jetmarket/presentation/choice_payment/section/payment_methode_section.dart';

import 'controllers/choice_payment.controller.dart';
import 'section/summary_payment.dart';

class ChoicePaymentScreen extends GetView<ChoicePaymentController> {
  const ChoicePaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarChoicePayment,
      body: ListView(
        children: const [SummaryPayment(), PaymentMethodeSection()],
      ),
    );
  }
}
