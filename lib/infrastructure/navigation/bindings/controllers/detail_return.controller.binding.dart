import 'package:get/get.dart';

import '../../../../presentation/detail_return/controllers/detail_return.controller.dart';

class DetailReturnControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailReturnController>(
      () => DetailReturnController(),
    );
  }
}
