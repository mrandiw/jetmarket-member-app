import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/loan_repository_impl.dart';

import '../../../../presentation/koperasi_pages/daftar_pengajuan_pinjaman/controllers/daftar_pengajuan_pinjaman.controller.dart';

class DaftarPengajuanPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarPengajuanPinjamanController>(
      () => DaftarPengajuanPinjamanController(LoanRepositoryImpl()),
    );
  }
}
