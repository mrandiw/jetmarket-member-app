import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';
import 'package:jetmarket/presentation/auth/register/controllers/register.controller.dart';

import '../../../../presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';

class DetailPaymentRegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPaymentRegisterController>(
      () => DetailPaymentRegisterController(AuthRepositoryImpl()),
    );

    // Get.lazyPut<RegisterController>(
    //   () => RegisterController(AuthRepositoryImpl()),
    // );
  }
}
