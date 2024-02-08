import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/product_repository_impl.dart';

import '../../../../presentation/home_pages/voucher/controllers/voucher.controller.dart';

class VoucherControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherController>(
      () => VoucherController(ProductRepositoryImpl()),
    );
  }
}
