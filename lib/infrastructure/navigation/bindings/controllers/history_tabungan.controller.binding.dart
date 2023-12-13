import 'package:get/get.dart';

import '../../../../presentation/koperasi_pages/history_tabungan/controllers/history_tabungan.controller.dart';

class HistoryTabunganControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryTabunganController>(
      () => HistoryTabunganController(),
    );
  }
}
