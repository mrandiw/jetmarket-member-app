import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_tagihan_bulanan/section/status_section.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/detail_tagihan_bulanan.controller.dart';
import 'section/app_bar_section.dart';
import 'section/button_section.dart';
import 'section/information_section.dart';

class DetailTagihanBulananScreen
    extends GetView<DetailTagihanBulananController> {
  const DetailTagihanBulananScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Widget successWidget() {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.actionBack();
        return true;
      },
      child: Scaffold(
        appBar: appBarDetailTagihanBulanan(controller),
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: [
            StatusTagihanBulanan(controller: controller),
            InformationSection(controller: controller)
          ],
        ),
        bottomNavigationBar: ButtonSection(
          controller: controller,
        ),
      ),
    );
  }
}
