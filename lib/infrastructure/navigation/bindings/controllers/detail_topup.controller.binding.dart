import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/ewallet_repository_impl.dart';

import '../../../../presentation/wallet/detail_topup/controllers/detail_topup.controller.dart';

class DetailTopupControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTopupController>(
      () => DetailTopupController(EwalletRepositoryImpl()),
    );
  }
}
