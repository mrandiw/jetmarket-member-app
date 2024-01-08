import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/payment_repository_impl.dart';
import '../../../../presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';

class DetailPaymentRegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPaymentRegisterController>(
      () => DetailPaymentRegisterController(PaymentRepositoryImpl()),
    );

    // Get.lazyPut<RegisterController>(
    //   () => RegisterController(AuthRepositoryImpl()),
    // );
  }
}
