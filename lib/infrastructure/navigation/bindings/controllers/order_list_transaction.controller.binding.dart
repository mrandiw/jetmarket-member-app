import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/order_repository_impl.dart';

import '../../../../presentation/order_pages/order_list_transaction/controllers/order_list_transaction.controller.dart';

class OrderListTransactionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      OrderListTransactionController(OrderRepositoryImpl()),
    );
  }
}
