import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/file_repository_impl.dart';

import '../../../../presentation/order_pages/komplain/controllers/komplain.controller.dart';
import '../../../dal/repository/order_repository_impl.dart';

class KomplainControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomplainController>(
      () => KomplainController(OrderRepositoryImpl(), FileRepositoryImpl()),
    );
  }
}
