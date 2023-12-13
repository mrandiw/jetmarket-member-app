import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/pengajuan_proses_pinjaman.controller.dart';

class PengajuanProsesPinjamanScreen
    extends GetView<PengajuanProsesPinjamanController> {
  const PengajuanProsesPinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengajuanProsesPinjamanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengajuanProsesPinjamanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
