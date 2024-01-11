import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/tracking_return.controller.dart';
import 'section/app_bar_section.dart';
import 'section/step_refund_section.dart';
import 'section/step_status_section.dart';

class TrackingReturnScreen extends GetView<TrackingReturnController> {
  const TrackingReturnScreen({Key? key}) : super(key: key);
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
  }

  Scaffold successWidget(TrackingReturnController controller) {
    return Scaffold(
        appBar: appBarTrackingRefund,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: const [StepStatusSection()],
        ));
  }
}
