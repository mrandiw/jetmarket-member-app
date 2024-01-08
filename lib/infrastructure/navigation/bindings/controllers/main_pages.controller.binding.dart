import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';
import '../../../../presentation/account_pages/account/controllers/account.controller.dart';
import '../../../../presentation/home_pages/home/controllers/home.controller.dart';
import '../../../../presentation/koperasi_pages/koperasi/controllers/koperasi.controller.dart';
import '../../../../presentation/main_pages/controllers/main_pages.controller.dart';
import '../../../../presentation/order_pages/order/controllers/order.controller.dart';
import '../../../dal/repository/auth_repository_impl.dart';
import '../../../dal/repository/order_repository_impl.dart';
import '../../../dal/repository/product_repository_impl.dart';

class MainPagesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPagesController>(
      () => MainPagesController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(ProductRepositoryImpl()),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(OrderRepositoryImpl()),
    );
    Get.lazyPut<AccountController>(
      () => AccountController(AuthRepositoryImpl()),
    );
    Get.lazyPut<KoperasiController>(
      () => KoperasiController(),
    );
    Get.lazyPut<EWalletController>(
      () => EWalletController(),
    );
  }
}
