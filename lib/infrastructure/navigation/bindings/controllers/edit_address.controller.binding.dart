import 'package:get/get.dart';

import '../../../../presentation/home_pages/edit_address/controllers/edit_address.controller.dart';

class EditAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(
      () => EditAddressController(),
    );
  }
}
