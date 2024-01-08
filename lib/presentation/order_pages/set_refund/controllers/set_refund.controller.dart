import 'package:get/get.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/delivery_repository.dart';
import '../../../../domain/core/model/model_data/delivery_model.dart';
import '../../../../domain/core/model/model_data/select_delivery.dart';
import '../../../../domain/core/model/params/address/item_product_for_delivery.dart';
import '../../../../utils/network/status_response.dart';

class SetRefundController extends GetxController {
  final DeliveryRepository _deliveryRepository;
  SetRefundController(this._deliveryRepository);
  List<dynamic> deliverys = [];
  List<DeliveryModel> listDelivery = [];
  List<SelectDelivery> selectedDelivery = [];
  List<bool> isExpandedTile = [];

  Future<void> getDelivery(ItemProductForDelivery body) async {
    final response = await _deliveryRepository.getDelivery(body);
    if (response.status == StatusResponse.success) {
      listDelivery = response.result ?? [];
      update();
    } else {
      AppSnackbar.show(message: response.message, type: SnackType.error);
    }
  }

  //  setAddress() {
  //     isExpandedTile = List.generate(productCart.length, (index) => false);
  //     getDelivery(body);
  // }
}
