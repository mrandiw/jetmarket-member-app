import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/auth/register_otp/controllers/register_otp.controller.dart';

class RegisterOtpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterOtpController>(
      () => RegisterOtpController(AuthRepositoryImpl()),
    );
  }
}
