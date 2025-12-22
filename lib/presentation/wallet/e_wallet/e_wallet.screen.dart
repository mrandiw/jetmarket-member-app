import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/e_wallet.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';
import 'section/history_section.dart';

class EWalletScreen extends StatefulWidget {
  const EWalletScreen({super.key});

  @override
  State<EWalletScreen> createState() => _EWalletScreenState();
}

class _EWalletScreenState extends State<EWalletScreen> {
  late final EWalletController controller;
  late final RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<EWalletController>();
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarEwallet,
        backgroundColor: kWhite,
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: refreshController,
          onRefresh: () => controller.onRefresh(refreshController),
          onLoading: () => controller.onLoading(refreshController),
          header: const WaterDropHeader(
            waterDropColor: kPrimaryColor,
            complete: SizedBox.shrink(),
            refresh: CupertinoActivityIndicator(
              color: kSoftGrey,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              HeaderSection(controller: controller),
              HistorySection(
                controller: controller,
              )
            ],
          ),
        ));
  }
}
