import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/section/summary_payment.dart';

import '../section/detail_section.dart';

class BankTransfer extends StatelessWidget {
  const BankTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [SummaryPayment(), DetailSection()],
      ),
    );
  }
}
