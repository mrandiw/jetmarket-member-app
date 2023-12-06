import 'package:get/get.dart';

import '../../../../presentation/address/controllers/address.controller.dart';

class AddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
  }
}
