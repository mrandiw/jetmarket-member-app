import '../../../utils/network/data_state.dart';
import '../model/model_data/delivery_model.dart';
import '../model/model_data/set_refund_model.dart';
import '../model/params/address/item_product_for_delivery.dart';
import '../model/params/order/set_refund_param.dart';

abstract class DeliveryRepository {
  Future<DataState<List<DeliveryModel>>> getDelivery(
      ItemProductForDelivery body);
  Future<DataState<SetRefundModel>> getSetRefundOrder(int id);
  Future<DataState<String>> setRefundOrder(SetRefundParam param);
}
