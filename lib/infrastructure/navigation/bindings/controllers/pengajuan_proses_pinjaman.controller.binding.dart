import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/pengajuan_proses_pinjaman/controllers/pengajuan_proses_pinjaman.controller.dart';

class PengajuanProsesPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengajuanProsesPinjamanController>(
      () => PengajuanProsesPinjamanController(),
    );
  }
}
