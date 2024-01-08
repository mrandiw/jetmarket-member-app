import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../domain/core/model/model_data/detail_refund_model.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class RincianRefundController extends GetxController {
  final OrderRepository _orderRepository;

  RincianRefundController(this._orderRepository);
  var screenStatus = (ScreenStatus.initalize).obs;

  DetailRefundModel? detailRefund;

  int? selectedProofsIndex;
  String? descriptionSelectedProofsIndex;
  List<String> proofsDesc = [
    'Faktur Pajak',
    'Tanda Tangan',
  ];

  Future<void> getRefundStatus() async {
    screenStatus(ScreenStatus.loading);
    final response = await _orderRepository.getRefundStatus(1);
    if (response.status == StatusResponse.success) {
      detailRefund = response.result;
      screenStatus(ScreenStatus.success);
      update();
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void setSelectedProofsIndex(int index, String desc) {
    if (selectedProofsIndex == index) {
      selectedProofsIndex = null;
      descriptionSelectedProofsIndex = null;
      update();
    } else {
      selectedProofsIndex = index;
      descriptionSelectedProofsIndex = desc;
      update();
    }
  }

  void toStore(int id) {
    Get.toNamed(Routes.DETAIL_STORE,
        arguments: {'seller_id': id, 'product_id': 1});
  }

  @override
  void onInit() {
    getRefundStatus();
    super.onInit();
  }
}
