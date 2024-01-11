import 'package:get/get.dart';

import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/tracking_order.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class TrackingOrderController extends GetxController {
  final OrderRepository _orderRepository;

  TrackingOrderController(this._orderRepository);
  var screenStatus = (ScreenStatus.initalize).obs;

  TrackingOrderModel? trackingOrder;

  Future<void> getTrackingOrder() async {
    screenStatus(ScreenStatus.loading);
    final response = await _orderRepository.trackingOrder(Get.arguments);
    if (response.status == StatusResponse.success) {
      screenStatus(ScreenStatus.success);
      trackingOrder = response.result;
      update();
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  @override
  void onInit() {
    getTrackingOrder();
    super.onInit();
  }
}
