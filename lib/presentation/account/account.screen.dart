import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/account/section/app_bar_section.dart';
import 'package:jetmarket/presentation/account/section/menu_section.dart';
import 'package:jetmarket/presentation/account/section/profile_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/account.controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: appBarAccount,
        body: ListView(
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
        ));
  }
}
