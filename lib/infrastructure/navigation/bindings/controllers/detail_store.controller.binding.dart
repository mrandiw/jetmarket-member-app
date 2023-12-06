import 'package:get/get.dart';

import '../../../../presentation/detail_store/controllers/detail_store.controller.dart';

class DetailStoreControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStoreController>(
      () => DetailStoreController(),
    );
  }
}
