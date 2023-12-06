import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/section/retail_code_step.dart';

import '../section/summary_payment.dart';

class RetailOutlet extends StatelessWidget {
  const RetailOutlet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(
      children: [SummaryPayment(), RetailCodeStep()],
    ));
  }
}
