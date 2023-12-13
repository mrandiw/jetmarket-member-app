import 'package:flutter/material.dart';

import '../section/form_ewallet_section.dart';
import '../section/summary_payment.dart';

class EWallet extends StatelessWidget {
  const EWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [SummaryPayment(), FormEwalletSection()],
      ),
    );
  }
}
