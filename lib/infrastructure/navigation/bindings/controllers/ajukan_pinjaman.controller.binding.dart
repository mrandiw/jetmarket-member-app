import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/ajukan_pinjaman/controllers/ajukan_pinjaman.controller.dart';

class AjukanPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AjukanPinjamanController>(
      () => AjukanPinjamanController(),
    );
  }
}
