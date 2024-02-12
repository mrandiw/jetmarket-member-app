import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_menabung/section/detail_saving.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/detail_menabung.controller.dart';
import 'section/app_bar_section.dart';

class DetailMenabungScreen extends GetView<DetailMenabungController> {
  const DetailMenabungScreen({super.key});
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

  Widget successWidget(DetailMenabungController controller) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          controller.actionBack();
          return true;
        },
        child: Scaffold(
            appBar: appBarDetailSaving(controller),
            body: const DetailSaving()));
  }
}
