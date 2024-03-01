import 'package:flutter/material.dart';

import '../controllers/tagihan_payment_bill.controller.dart';
import '../section/qris_section.dart';
import '../section/retail_section.dart';
import '../section/virtual_account_section.dart';
import '../section/wallet_section.dart';

class PaymentType extends StatelessWidget {
  const PaymentType({super.key, required this.type, required this.controller});
  final PaymentMethodeType type;
  final TagihanPaymentBillController controller;

  @override
  Widget build(BuildContext context) {
    if (type == PaymentMethodeType.va) {
      return VirtualAccountSection(controller: controller);
    } else if (type == PaymentMethodeType.qris) {
      return QrisSection(controller: controller);
    } else if (type == PaymentMethodeType.retail) {
      return RetailSection(controller: controller);
    } else if (type == PaymentMethodeType.wallet) {
      return WalletSection(controller: controller);
    } else {
      return const SizedBox.shrink();
    }
  }
}
