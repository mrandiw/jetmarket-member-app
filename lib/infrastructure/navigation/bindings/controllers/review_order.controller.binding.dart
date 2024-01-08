import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/dal/repository/review_repository_impl.dart';

import '../../../../presentation/order_pages/review_order/controllers/review_order.controller.dart';
import '../../../dal/repository/file_repository_impl.dart';

class ReviewOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewOrderController>(
      () => ReviewOrderController(FileRepositoryImpl(), ReviewRepositoryImpl()),
    );
  }
}
