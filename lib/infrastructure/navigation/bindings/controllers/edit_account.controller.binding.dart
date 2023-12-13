import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/account_pages/edit_account/controllers/edit_account.controller.dart';

class EditAccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAccountController>(
      () => EditAccountController(AuthRepositoryImpl()),
    );
  }
}
