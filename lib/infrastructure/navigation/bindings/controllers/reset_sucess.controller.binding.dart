import 'package:get/get.dart';

import '../../../../presentation/auth/reset_sucess/controllers/reset_sucess.controller.dart';

class ResetSucessControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetSucessController>(
      () => ResetSucessController(),
    );
  }
}
