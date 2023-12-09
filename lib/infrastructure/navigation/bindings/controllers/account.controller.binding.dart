import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/account/controllers/account.controller.dart';

class AccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
      () => AccountController(AuthRepositoryImpl()),
    );
  }
}
