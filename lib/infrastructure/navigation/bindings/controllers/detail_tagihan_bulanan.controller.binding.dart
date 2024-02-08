import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/loan_repository_impl.dart';

import '../../../../presentation/koperasi_pages/detail_tagihan_bulanan/controllers/detail_tagihan_bulanan.controller.dart';

class DetailTagihanBulananControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTagihanBulananController>(
      () => DetailTagihanBulananController(LoanRepositoryImpl()),
    );
  }
}
