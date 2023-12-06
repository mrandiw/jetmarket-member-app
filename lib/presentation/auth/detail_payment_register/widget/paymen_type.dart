import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/section/qris_section.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/section/retail_section.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/section/virtual_account_section.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/section/wallet_section.dart';

class PaymentType extends StatelessWidget {
  const PaymentType({super.key, required this.type, required this.controller});
  final PaymentMethodeType type;
  final DetailPaymentRegisterController controller;

  @override
  Widget build(BuildContext context) {
    if (type == PaymentMethodeType.va) {
      return VirtualAccountSection(controller: controller);
    } else if (type == PaymentMethodeType.qris) {
      return const QrisSection();
    } else if (type == PaymentMethodeType.retail) {
      return const RetailSection();
    } else if (type == PaymentMethodeType.wallet) {
      return const WalletSection();
    } else {
      return const SizedBox.shrink();
    }
  }
}
