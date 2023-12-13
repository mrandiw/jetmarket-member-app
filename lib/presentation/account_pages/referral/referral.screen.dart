import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/referral.controller.dart';
import 'section/app_bar_section.dart';
import 'section/code_referral_section.dart';
import 'section/history_section.dart';
import 'section/list_account_section.dart';

class ReferralScreen extends GetView<ReferralController> {
  const ReferralScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (_, inBoxScrolled) {
                return [
                  AppBarReferral(
                    tabController: controller.tabController,
                    controller: controller,
                    isScroll: inBoxScrolled,
                  ),
                ];
              },
              body: TabBarView(
                  controller: controller.tabController,
                  children: const [HistorySection(), ListAccountSection()])),
        ));
  }
}
