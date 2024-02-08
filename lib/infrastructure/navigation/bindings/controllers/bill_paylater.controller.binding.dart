import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/paylater_repository_impl.dart';

import '../../../../presentation/account_pages/bill_paylater/controllers/bill_paylater.controller.dart';

class BillPaylaterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillPaylaterController>(
      () => BillPaylaterController(PaylaterRepositoryImpl()),
    );
  }
}
