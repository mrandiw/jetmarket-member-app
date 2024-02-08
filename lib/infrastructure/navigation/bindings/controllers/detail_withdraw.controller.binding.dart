import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/ewallet_repository_impl.dart';

import '../../../../presentation/wallet/detail_withdraw/controllers/detail_withdraw.controller.dart';

class DetailWithdrawControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWithdrawController>(
      () => DetailWithdrawController(EwalletRepositoryImpl()),
    );
  }
}
