import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/daftar_pengajuan_pinjaman.controller.dart';
import 'section/app_bar_section.dart';
import 'section/filter_section.dart';
import 'section/list_pengajuan.dart';

class DaftarPengajuanPinjamanScreen
    extends GetView<DaftarPengajuanPinjamanController> {
  const DaftarPengajuanPinjamanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      const AppBarDaftarPengajuan(),
      const FilterSection(),
      ListPengajuan(controller: controller)
    ]));
  }
}
