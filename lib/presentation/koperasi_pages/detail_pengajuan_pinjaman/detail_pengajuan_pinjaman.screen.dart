import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_pengajuan_pinjaman.controller.dart';

class DetailPengajuanPinjamanScreen
    extends GetView<DetailPengajuanPinjamanController> {
  const DetailPengajuanPinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPengajuanPinjamanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPengajuanPinjamanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
