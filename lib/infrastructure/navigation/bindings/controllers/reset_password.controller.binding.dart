import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/auth/reset_password/controllers/reset_password.controller.dart';

class ResetPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(AuthRepositoryImpl()),
    );
  }
}
