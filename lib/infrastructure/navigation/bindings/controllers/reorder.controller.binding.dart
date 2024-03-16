import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/home_pages/reorder/controllers/reorder.controller.dart';

class ReorderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReorderController(OrderRepositoryImpl()));
  }
}
