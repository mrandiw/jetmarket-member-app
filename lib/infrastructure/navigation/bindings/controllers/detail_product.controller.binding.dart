import 'package:get/get.dart';

import '../../../../presentation/detail_product/controllers/detail_product.controller.dart';

class DetailProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductController>(
      () => DetailProductController(),
    );
  }
}
