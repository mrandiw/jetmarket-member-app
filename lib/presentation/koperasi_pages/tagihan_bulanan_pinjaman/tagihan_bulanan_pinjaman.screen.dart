import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/tagihan_bulanan_pinjaman/section/app_bar_section.dart';
import 'package:jetmarket/presentation/koperasi_pages/tagihan_bulanan_pinjaman/section/list_pengajuan.dart';

import 'controllers/tagihan_bulanan_pinjaman.controller.dart';

class TagihanBulananPinjamanScreen
    extends GetView<TagihanBulananPinjamanController> {
  const TagihanBulananPinjamanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      const AppBarTagihanBulanan(),
      ListTagihanBulanan(controller: controller)
    ]));
  }
}
