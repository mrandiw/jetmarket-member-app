import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/product_repository_impl.dart';

import '../../../../presentation/home_pages/detail_product/controllers/detail_product.controller.dart';

class DetailProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductController>(
      () => DetailProductController(ProductRepositoryImpl()),
    );
  }
}
