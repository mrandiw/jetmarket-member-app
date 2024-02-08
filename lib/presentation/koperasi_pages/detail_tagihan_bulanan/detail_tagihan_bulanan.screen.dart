import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_tagihan_bulanan/section/status_section.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/detail_tagihan_bulanan.controller.dart';
import 'section/app_bar_section.dart';
import 'section/information_section.dart';

class DetailTagihanBulananScreen
    extends GetView<DetailTagihanBulananController> {
  const DetailTagihanBulananScreen({Key? key}) : super(key: key);
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

  Scaffold successWidget() {
    return Scaffold(
        appBar: appBarDetailTagihanBulanan,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: [
            StatusTagihanBulanan(controller: controller),
            InformationSection(controller: controller)
          ],
        ));
  }
}
