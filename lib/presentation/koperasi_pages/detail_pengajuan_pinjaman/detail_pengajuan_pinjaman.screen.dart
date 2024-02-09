import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_pengajuan_pinjaman/section/information_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/parent/parent_scaffold.dart';
import 'controllers/detail_pengajuan_pinjaman.controller.dart';
import 'section/app_bar_section.dart';
import 'section/status_section.dart';

class DetailPengajuanPinjamanScreen
    extends GetView<DetailPengajuanPinjamanController> {
  const DetailPengajuanPinjamanScreen({super.key});
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
        appBar: appBarDetailPengajuanPinjaman,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: [
            StatusPengajuanPinjaman(controller: controller),
            InformationSection(controller: controller)
          ],
        ));
  }
}
