import 'package:get/get.dart';
import '../../../../presentation/home_pages/checkout/controllers/checkout.controller.dart';
import '../../../dal/repository/delivery_repository_impl.dart';

class CheckoutControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(DeliveryRepositoryImpl()),
    );
  }
}
