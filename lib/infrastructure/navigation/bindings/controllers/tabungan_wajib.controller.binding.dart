import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/mandatory_saving_repository_impl.dart';

import '../../../../presentation/koperasi_pages/tabungan_wajib/controllers/tabungan_wajib.controller.dart';

class TabunganWajibControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabunganWajibController>(
      () => TabunganWajibController(MandatorySavingRepositoryImpl()),
    );
  }
}
