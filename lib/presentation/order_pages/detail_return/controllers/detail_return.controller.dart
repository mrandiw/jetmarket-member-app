import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../../../../domain/core/model/model_data/detail_refund_model.dart';

class DetailReturnController extends GetxController {
  DetailRefundModel? detailRefund;

  int? selectedProofsIndex;
  String? descriptionSelectedProofsIndex;
  List<String> proofsDesc = [
    'Faktur Pajak',
    'Tanda Tangan',
  ];

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

  void toTrackingRefund() {
    Get.toNamed(Routes.TRACKING_RETURN, arguments: 1);
  }

  @override
  void onInit() {
    // detailRefund = Get.arguments;
    super.onInit();
  }
}
