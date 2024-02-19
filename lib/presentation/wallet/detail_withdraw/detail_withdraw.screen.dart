import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/detail_withdraw/section/app_bar_section.dart';
import 'package:jetmarket/presentation/wallet/detail_withdraw/section/detail_wd.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/error_page.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/detail_withdraw.controller.dart';

class DetailWithdrawScreen extends GetView<DetailWithdrawController> {
  const DetailWithdrawScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onError: const ErrorPage(),
        onSuccess: successWidget(),
        status: controller.screenStatus.value));
  }

  Widget successWidget() =>
      // ignore: deprecated_member_use
      WillPopScope(
          onWillPop: () async {
            controller.actionBack();
            return true;
          },
          child: Scaffold(
              appBar: appBarDetailWithdraw(controller),
              body: const DetailWd()));
}
