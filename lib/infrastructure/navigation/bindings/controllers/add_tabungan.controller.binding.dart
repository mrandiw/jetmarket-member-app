import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/add_tabungan/controllers/add_tabungan.controller.dart';

class AddTabunganControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTabunganController>(
      () => AddTabunganController(),
    );
  }
}
