import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/paylater_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/bill_paylater_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_paylater_model.dart';
import 'package:jetmarket/domain/core/model/params/paylater/bill_paylater_body.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/remote/remote_provider.dart';

import '../../../domain/core/model/model_data/detail_bill_paylater.dart';
import '../../../domain/core/model/model_data/detail_payment_paylater.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';

class PaylaterRepositoryImpl implements PayLaterRepository {
  @override
  Future<DataState<DetailPaylaterModel>> getDetailPaylater() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.paylaterDetail);
      return DataState<DetailPaylaterModel>(
        status: StatusCodeResponse.cek(response: response),
        result: DetailPaylaterModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<DetailPaylaterModel>().dio(e);
    }
  }

  @override
  Future<DataState<List<BillPaylaterModel>>> getBillPaylater(
      {required int page, required int size}) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.paylaterBill,
          queryParameters: {'page': page, 'size': size});
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<BillPaylaterModel>>(
        status: StatusCodeResponse.cek(response: response),
        result: datas.map((e) => BillPaylaterModel.fromJson(e)).toList(),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<BillPaylaterModel>>().dio(e);
    }
  }

  @override
  Future<DataState<DetailBillPaylater>> getDetailBillPaylater(
      String refId) async {
    String modifiedId = refId.replaceAll('#', '%23');
    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.orderCustomer}/detail/$modifiedId');
      return DataState<DetailBillPaylater>(
        status: StatusCodeResponse.cek(response: response),
        result: DetailBillPaylater.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<DetailBillPaylater>().dio(e);
    }
  }

  @override
  Future<DataState<DetailPaymentPaylater>> paylaterPay(
      BillPaylaterBody body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.paylaterPay, data: body.toMap());
      return DataState<DetailPaymentPaylater>(
        status: StatusCodeResponse.cek(response: response),
        result: DetailPaymentPaylater.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<DetailPaymentPaylater>().dio(e);
    }
  }
}
