import 'package:get/get.dart';

import '../../../../presentation/home_pages/address/controllers/address.controller.dart';

class AddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
  }
}
