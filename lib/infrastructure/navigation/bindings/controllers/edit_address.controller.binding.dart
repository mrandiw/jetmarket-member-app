import 'package:get/get.dart';

import '../../../../presentation/edit_address/controllers/edit_address.controller.dart';

class EditAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(
      () => EditAddressController(),
    );
  }
}
