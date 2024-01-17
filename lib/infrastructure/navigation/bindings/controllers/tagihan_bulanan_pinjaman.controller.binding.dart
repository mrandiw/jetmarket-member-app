import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/tagihan_bulanan_pinjaman/controllers/tagihan_bulanan_pinjaman.controller.dart';

class TagihanBulananPinjamanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagihanBulananPinjamanController>(
      () => TagihanBulananPinjamanController(),
    );
  }
}
