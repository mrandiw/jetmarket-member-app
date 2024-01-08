import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key, required this.controller});
  final DetailPaymentRegisterController controller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailPaymentRegisterController>(builder: (controller) {
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
