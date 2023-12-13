import 'package:get/get.dart';

import '../../../../presentation/account_pages/review_product/controllers/review_product.controller.dart';

class ReviewProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewProductController>(
      () => ReviewProductController(),
    );
  }
}
