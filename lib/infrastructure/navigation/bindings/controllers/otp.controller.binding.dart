import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/auth/otp/controllers/otp.controller.dart';

class OtpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(AuthRepositoryImpl()),
    );
  }
}
