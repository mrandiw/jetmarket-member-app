import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';

import '../../../../domain/core/model/model_data/tracking_refund_model.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class TrackingReturnController extends GetxController {
  final OrderRepository _orderRepository;

  TrackingReturnController(this._orderRepository);
  var screenStatus = (ScreenStatus.initalize).obs;

  TrackingRefundModel? trackingRefund;

  Future<void> getTrackingRefund() async {
    screenStatus(ScreenStatus.loading);

    final response = await _orderRepository.trackingRefund(Get.arguments);
    if (response.status == StatusResponse.success) {
      screenStatus(ScreenStatus.success);
      trackingRefund = response.result;
      update();
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  @override
  void onInit() {
    getTrackingRefund();
    super.onInit();
  }
}
