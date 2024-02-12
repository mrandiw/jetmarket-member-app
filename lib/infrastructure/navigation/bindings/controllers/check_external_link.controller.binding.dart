import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/check_external_link/controllers/check_external_link.controller.dart';

class CheckExternalLinkControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckExternalLinkController>(
      () => CheckExternalLinkController(AuthRepositoryImpl()),
    );
  }
}
