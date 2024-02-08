import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/account_pages/review_product/controllers/review_product.controller.dart';

class ReviewProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewProductController>(
      () => ReviewProductController(OrderRepositoryImpl()),
    );
  }
}
