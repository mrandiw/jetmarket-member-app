import 'package:get/get.dart';

import '../../../../presentation/list_address/controllers/list_address.controller.dart';

class ListAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListAddressController>(
      () => ListAddressController(),
    );
  }
}
