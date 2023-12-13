import 'package:get/get.dart';

import '../../../../presentation/home_pages/detail_checkout/controllers/detail_checkout.controller.dart';

class DetailCheckoutControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCheckoutController>(
      () => DetailCheckoutController(),
    );
  }
}
