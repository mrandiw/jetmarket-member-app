import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import '../controllers/tagihan_payment_bill.controller.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key, required this.controller});
  final TagihanPaymentBillController controller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TagihanPaymentBillController>(builder: (controller) {
      return Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: kPrimaryColor2))),
        child: TabBar(
          controller: controller.tabController,
          tabs: controller.tutorialPayment?.tabs
                  ?.map((e) => Tab(
                        text: e,
                      ))
                  .toList() ??
              <Tab>[],
          isScrollable: (controller.tutorialPayment?.tabs?.length ?? 0) > 3,
          labelStyle: text14PrimarySemiBold,
          indicatorColor: kSecondaryColor,
          labelColor: kSecondaryColor,
          unselectedLabelColor: kBorder,
        ),
      );
    });
  }
}