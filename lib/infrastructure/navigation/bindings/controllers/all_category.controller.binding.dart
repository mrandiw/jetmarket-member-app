import 'package:get/get.dart';

import '../../../../presentation/home_pages/all_category/controllers/all_category.controller.dart';

class AllCategoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCategoryController>(
      () => AllCategoryController(),
    );
  }
}
