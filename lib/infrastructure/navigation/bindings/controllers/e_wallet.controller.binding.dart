import 'package:get/get.dart';

import '../../../../presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';
import '../../../dal/repository/ewallet_repository_impl.dart';

class EWalletControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EWalletController>(
      () => EWalletController(EwalletRepositoryImpl()),
    );
  }
}
