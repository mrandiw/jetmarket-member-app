import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/address_repository_impl.dart';

import '../../../../presentation/home_pages/edit_address/controllers/edit_address.controller.dart';

class EditAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(
      () => EditAddressController(AddressRepositoryImpl()),
    );
  }
}
