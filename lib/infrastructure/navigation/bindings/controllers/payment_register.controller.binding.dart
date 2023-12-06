import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/auth_repository_impl.dart';

import '../../../../presentation/auth/payment_register/controllers/payment_register.controller.dart';

class PaymentRegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentRegisterController>(
      () => PaymentRegisterController(AuthRepositoryImpl()),
    );
  }
}
