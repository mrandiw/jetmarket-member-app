import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/auth/forgot_password/controllers/forgot_password.controller.dart';

class ForgotPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(AuthRepositoryImpl()),
    );
  }
}
