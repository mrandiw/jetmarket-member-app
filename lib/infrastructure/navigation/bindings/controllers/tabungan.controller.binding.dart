import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/saving_repository_impl.dart';

import '../../../../presentation/koperasi_pages/tabungan/controllers/tabungan.controller.dart';

class TabunganControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabunganController>(
      () => TabunganController(SavingRepositoryImpl()),
    );
  }
}
