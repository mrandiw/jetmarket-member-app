import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/paylater_repository_impl.dart';

import '../../../../presentation/account_pages/paylater_customer/controllers/paylater_customer.controller.dart';

class PaylaterCustomerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaylaterCustomerController>(
      () => PaylaterCustomerController(PaylaterRepositoryImpl()),
    );
  }
}
