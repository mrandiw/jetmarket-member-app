import 'package:get/get.dart';

import '../../../../presentation/account_pages/referral/controllers/referral.controller.dart';

class ReferralControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferralController>(
      () => ReferralController(),
    );
  }
}
