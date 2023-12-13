import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/detail_pengajuan_pinjaman/controllers/detail_pengajuan_pinjaman.controller.dart';

class DetailPengajuanPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPengajuanPinjamanController>(
      () => DetailPengajuanPinjamanController(),
    );
  }
}
