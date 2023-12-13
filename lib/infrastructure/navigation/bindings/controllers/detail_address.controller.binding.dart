import 'package:get/get.dart';

import '../../../../presentation/home_pages/detail_address/controllers/detail_address.controller.dart';

class DetailAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAddressController>(
      () => DetailAddressController(),
    );
  }
}
