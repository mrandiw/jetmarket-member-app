import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/saving_repository_impl.dart';

import '../../../../presentation/koperasi_pages/add_tabungan_manual/controllers/add_tabungan_manual.controller.dart';

class AddTabunganManualControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTabunganManualController>(
      () => AddTabunganManualController(SavingRepositoryImpl()),
    );
  }
}
