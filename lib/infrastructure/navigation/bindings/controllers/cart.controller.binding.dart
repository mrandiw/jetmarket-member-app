import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/cart_repository_impl.dart';

import '../../../../presentation/home_pages/cart/controllers/cart.controller.dart';

class CartControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(CartRepositoryImpl()),
    );
  }
}
