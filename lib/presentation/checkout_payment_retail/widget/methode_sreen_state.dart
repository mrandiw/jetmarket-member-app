import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/widget/bank_transfer.dart';

import 'e_wallet.dart';
import 'retail_outlet.dart';

class MethodeScreenState extends StatelessWidget {
  const MethodeScreenState({super.key, required this.methode});

  final String methode;

  @override
  Widget build(BuildContext context) {
    if (methode == "bank") {
      return const BankTransfer();
    } else if (methode == "wallet") {
      return const EWallet();
    } else {
      return const RetailOutlet();
    }
  }
}
