import 'package:get/get.dart';

import '../../../../presentation/auth/success_verify_otp/controllers/success_verify_otp.controller.dart';

class SuccessVerifyOtpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessVerifyOtpController>(
      () => SuccessVerifyOtpController(),
    );
  }
}
