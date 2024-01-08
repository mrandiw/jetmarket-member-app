import '../../../utils/network/data_state.dart';
import '../model/model_data/delivery_model.dart';
import '../model/params/address/item_product_for_delivery.dart';

abstract class DeliveryRepository {
  Future<DataState<List<DeliveryModel>>> getDelivery(
      ItemProductForDelivery body);
}
