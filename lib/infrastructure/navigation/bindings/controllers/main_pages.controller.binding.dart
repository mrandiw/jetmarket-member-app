import 'package:get/get.dart';
import 'package:jetmarket/presentation/order/controllers/order.controller.dart';

import '../../../../presentation/account/controllers/account.controller.dart';
import '../../../../presentation/main_pages/controllers/main_pages.controller.dart';
import '../../../dal/repository/auth_repository_impl.dart';

class MainPagesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPagesController>(
      () => MainPagesController(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<AccountController>(
      () => AccountController(AuthRepositoryImpl()),
    );
  }
}
