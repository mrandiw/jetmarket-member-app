import 'package:get/get.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/delivery_repository.dart';
import '../../../../domain/core/model/model_data/set_refund_model.dart';
import '../../../../domain/core/model/params/order/set_refund_param.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../order/controllers/order.controller.dart';

class SetRefundController extends GetxController {
  final DeliveryRepository _deliveryRepository;
  SetRefundController(this._deliveryRepository);

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = (ActionStatus.initalize).obs;

  SetRefundModel? setRefundModel;
  int? selectedIndexService;
  int? selectedIndexPackage;
  var selectedDelivery = false.obs;

  Future<void> getSetRefund() async {
    screenStatus(ScreenStatus.loading);
    final response = await _deliveryRepository.getSetRefundOrder(Get.arguments);
    if (response.status == StatusResponse.success) {
      setRefundModel = response.result;
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
      AppSnackbar.show(message: response.message, type: SnackType.error);
    }
  }

  updateChoiceDelivery(int indexService, int indexPackage) {
    selectedIndexService = indexService;
    selectedIndexPackage = indexPackage;
    update();
    selectedDelivery(true);
  }

  Future<void> submitSetRefund() async {
    actionButton(ActionStatus.loading);
    var param = SetRefundParam(
        id: Get.arguments,
        body: BodySetRefund(
          code: setRefundModel?.services?[selectedIndexService ?? 0]
              .packets?[selectedIndexPackage ?? 0].delivery?.code,
          serviceName: setRefundModel?.services?[selectedIndexService ?? 0]
              .packets?[selectedIndexPackage ?? 0].delivery?.serviceName,
          serviceCode: setRefundModel?.services?[selectedIndexService ?? 0]
              .packets?[selectedIndexPackage ?? 0].delivery?.serviceCode,
          rate: setRefundModel?.services?[selectedIndexService ?? 0]
              .packets?[selectedIndexPackage ?? 0].delivery?.rate,
        ));
    final response = await _deliveryRepository.setRefundOrder(param);
    if (response.status == StatusResponse.success) {
      actionButton(ActionStatus.success);
      Get.back();
      refreshOrder();
    } else {
      actionButton(ActionStatus.failed);
    }
  }

  void refreshOrder() {
    final controller = Get.find<OrderController>();
    controller.pagingController.refresh();
  }

  @override
  void onInit() {
    getSetRefund();
    super.onInit();
  }
}
