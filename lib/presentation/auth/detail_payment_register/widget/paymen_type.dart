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
