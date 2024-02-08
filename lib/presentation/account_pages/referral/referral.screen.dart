import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import 'controllers/referral.controller.dart';
import 'section/app_bar_section.dart';
import 'section/code_referral_section.dart';
import 'section/history_section.dart';

class ReferralScreen extends GetView<ReferralController> {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: appBarRefferal,
        body: CustomScrollView(
          slivers: [
            CodeReferralSection(controller: controller),
            HistorySection(
              controller: controller,
            ),
          ],
        ));
  }
}
