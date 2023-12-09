import 'package:get/get.dart';

import '../../../../presentation/success_change_password/controllers/success_change_password.controller.dart';

class SuccessChangePasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessChangePasswordController>(
      () => SuccessChangePasswordController(),
    );
  }
}
