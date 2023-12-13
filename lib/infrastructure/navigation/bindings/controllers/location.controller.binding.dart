import 'package:get/get.dart';

import '../../../../presentation/home_pages/location/controllers/location.controller.dart';
import '../../../dal/repository/address_repository_impl.dart';

class LocationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(
      () => LocationController(AddressRepositoryImpl()),
    );
  }
}
