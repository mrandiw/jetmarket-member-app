import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/tracking_order.controller.dart';
import 'section/app_bar_section.dart';
import 'section/step_status_section.dart';

class TrackingOrderScreen extends GetView<TrackingOrderController> {
  const TrackingOrderScreen({super.key});
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

  Scaffold successWidget(TrackingOrderController controller) {
    return Scaffold(
        appBar: appBarTrackingOrder,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: const [StepStatusSection()],
        ));
  }
}
