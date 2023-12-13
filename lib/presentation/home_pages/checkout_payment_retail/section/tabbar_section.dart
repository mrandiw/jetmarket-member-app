import 'package:flutter/material.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout_payment_retail/controllers/checkout_payment_retail.controller.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key, required this.controller});
  final CheckoutPaymentRetailController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: kPrimaryColor2))),
      child: TabBar(
        controller: controller.tabController,
        tabs: const [
          Tab(
            text: 'ATM',
          ),
          Tab(
            text: 'IBANKING',
          ),
          Tab(
            text: 'MBANKING',
          ),
        ],
        labelStyle: text14PrimarySemiBold,
        indicatorColor: kSecondaryColor,
        labelColor: kSecondaryColor,
        unselectedLabelColor: kBorder,
      ),
    );
  }
}
