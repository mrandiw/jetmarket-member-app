import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/detail_topup/section/detail_topup.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/error_page.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/detail_topup.controller.dart';
import 'section/app_bar_section.dart';

class DetailTopupScreen extends GetView<DetailTopupController> {
  const DetailTopupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onError: const ErrorPage(),
        onSuccess: successWidget(),
        status: controller.screenStatus.value));
  }

  Scaffold successWidget() =>
      Scaffold(appBar: appBarDetailTopup, body: const DetailTopup());
}
