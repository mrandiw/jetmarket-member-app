import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/auth/register/controllers/register.controller.dart';

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(AuthRepositoryImpl()),
    );
  }
}
