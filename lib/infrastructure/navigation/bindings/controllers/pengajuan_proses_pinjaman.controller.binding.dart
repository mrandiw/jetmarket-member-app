import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/loan_repository_impl.dart';

import '../../../../presentation/koperasi_pages/pengajuan_proses_pinjaman/controllers/pengajuan_proses_pinjaman.controller.dart';

class PengajuanProsesPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengajuanProsesPinjamanController>(
      () => PengajuanProsesPinjamanController(LoanRepositoryImpl()),
    );
  }
}
