import 'package:get/get.dart';
import '../../../../presentation/auth/payment_register/controllers/payment_register.controller.dart';
import '../../../dal/repository/payment_repository_impl.dart';

class PaymentRegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentRegisterController>(
      () => PaymentRegisterController(PaymentRepositoryImpl()),
    );
  }
}
