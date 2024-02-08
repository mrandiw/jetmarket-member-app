import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/paylater_repository_impl.dart';

import '../../../../presentation/account_pages/detail_bill_paylater/controllers/detail_bill_paylater.controller.dart';

class DetailBillPaylaterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBillPaylaterController>(
      () => DetailBillPaylaterController(PaylaterRepositoryImpl()),
    );
  }
}
