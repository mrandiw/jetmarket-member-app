import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/rincian_refund.controller.dart';
import 'section/app_bar_section.dart';
import 'section/detail_refund_section.dart';
import 'section/status_section.dart';

class RincianRefundScreen extends GetView<RincianRefundController> {
  const RincianRefundScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(controller),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
    // return successWidget(controller);
  }

  Scaffold successWidget(RincianRefundController controller) {
    return Scaffold(
        appBar: appBarRincianRefund,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: [
            StatusSection(controller: controller),
            DetailRefundSection(controller: controller)
          ],
        ));
  }
}
