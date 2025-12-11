import '../../../utils/network/data_state.dart';
import '../model/model_data/delivery_model.dart';
import '../model/model_data/ongkir_v2_response.dart';
import '../model/model_data/set_refund_model.dart';
import '../model/params/address/item_product_for_delivery.dart';
import '../model/params/delivery/check_ongkir_v2_param.dart';
import '../model/params/order/set_refund_param.dart';

abstract class DeliveryRepository {
  Future<DataState<List<DeliveryModel>>> getDelivery(
      ItemProductForDelivery body);

  /// Check ongkir V2 dengan tiered pricing & time slot management
  Future<DataState<OngkirV2Response>> checkOngkirV2(CheckOngkirV2Param param);

  Future<DataState<SetRefundModel>> getSetRefundOrder(int id);
  Future<DataState<String>> setRefundOrder(SetRefundParam param);
}
