import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/account_pages/account/section/app_bar_section.dart';
import 'package:jetmarket/presentation/account_pages/account/section/menu_section.dart';
import 'package:jetmarket/presentation/account_pages/account/section/profile_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controllers/account.controller.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late final AccountController controller;
  late final RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AccountController>();
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
        backgroundColor: kWhite,
        appBar: appBarAccount,
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
          child: ListView(
            children: [
              ProfileSection(controller: controller),
              Padding(
                padding: AppStyle.paddingSide16,
                child: Divider(
                  color: kBorder,
                  height: 0,
                ),
              ),
              MenuSection(controller: controller)
            ],
          ),
        ));
  }
}
