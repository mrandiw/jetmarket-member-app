import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/refferal_repository_impl.dart';

import '../../../../presentation/account_pages/referral/controllers/referral.controller.dart';

class ReferralControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferralController>(
      () => ReferralController(RefferalRepositoryImpl()),
    );
  }
}
