import 'package:get/get.dart';

import '../../../../presentation/home_pages/add_address/controllers/add_address.controller.dart';

class AddAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAddressController>(
      () => AddAddressController(),
    );
  }
}
