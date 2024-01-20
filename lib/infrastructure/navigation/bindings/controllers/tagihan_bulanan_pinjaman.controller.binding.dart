import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/loan_repository_impl.dart';

import '../../../../presentation/koperasi_pages/tagihan_bulanan_pinjaman/controllers/tagihan_bulanan_pinjaman.controller.dart';

class TagihanBulananPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagihanBulananPinjamanController>(
      () => TagihanBulananPinjamanController(LoanRepositoryImpl()),
    );
  }
}
