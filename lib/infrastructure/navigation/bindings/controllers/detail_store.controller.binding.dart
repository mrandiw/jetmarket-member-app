import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/product_repository_impl.dart';

import '../../../../presentation/home_pages/detail_store/controllers/detail_store.controller.dart';

class DetailStoreControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStoreController>(
      () => DetailStoreController(ProductRepositoryImpl()),
    );
  }
}
