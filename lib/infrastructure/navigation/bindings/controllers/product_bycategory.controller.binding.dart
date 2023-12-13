import 'package:get/get.dart';

import '../../../../presentation/home_pages/product_bycategory/controllers/product_bycategory.controller.dart';

class ProductBycategoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductBycategoryController>(
      () => ProductBycategoryController(),
    );
  }
}
