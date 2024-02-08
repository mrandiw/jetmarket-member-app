import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/file_repository_impl.dart';
import 'package:jetmarket/infrastructure/dal/repository/loan_repository_impl.dart';

import '../../../../presentation/koperasi_pages/ajukan_pinjaman/controllers/ajukan_pinjaman.controller.dart';

class AjukanPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AjukanPinjamanController>(
      () =>
          AjukanPinjamanController(LoanRepositoryImpl(), FileRepositoryImpl()),
    );
  }
}
