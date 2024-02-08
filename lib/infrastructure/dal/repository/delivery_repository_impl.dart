import 'package:dio/dio.dart';

import '../../../domain/core/interfaces/delivery_repository.dart';
import '../../../domain/core/model/model_data/delivery_model.dart';
import '../../../domain/core/model/model_data/set_refund_model.dart';
import '../../../domain/core/model/params/address/item_product_for_delivery.dart';
import '../../../domain/core/model/params/order/set_refund_param.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  @override
  Future<DataState<List<DeliveryModel>>> getDelivery(
      ItemProductForDelivery body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.checkOngkir, data: body.toJson());
      List<dynamic> datas = response.data['data'];
      return DataState<List<DeliveryModel>>(
          result: datas.map((e) => DeliveryModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<List<DeliveryModel>>().dio(e);
    }
  }

  @override
  Future<DataState<SetRefundModel>> getSetRefundOrder(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.deliverySetRefund}/$id');
      return DataState<SetRefundModel>(
          result: SetRefundModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<SetRefundModel>().dio(e);
    }
  }

  @override
  Future<DataState<String>> setRefundOrder(SetRefundParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: '${Endpoint.deliverySetRefund}/${param.id}',
          queryParameters: {'id': param.id ?? 0},
          data: param.body?.toMap());
      return DataState<String>(
          result: response.data['data'],
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }
}
