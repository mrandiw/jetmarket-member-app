import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/saving_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_direct_model.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_history_model.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_payment_methode_model.dart';
import 'package:jetmarket/domain/core/model/model_data/waiting_payment_model.dart';
import 'package:jetmarket/domain/core/model/params/saving/saving_direct_param.dart';
import 'package:jetmarket/domain/core/model/params/saving/saving_installment_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';

import '../../../domain/core/model/model_data/detail_saving_model.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/remote/remote_provider.dart';

class SavingRepositoryImpl implements SavingRepository {
  @override
  Future<DataState<DetailSavingModel>> getDetailSaving(int id) async {
    try {
      final response = await RemoteProvider.get(
          path: "${Endpoint.saving}/$id", queryParameters: {'id': id});
      return DataState<DetailSavingModel>(
          result: DetailSavingModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<DetailSavingModel>().dio(e);
    }
  }

  @override
  Future<DataState<int>> getTotalSaving() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.savingTotal);
      return DataState<int>(
          result: response.data['data']['total'],
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<List<SavingHistoryModel>>> getSavingHistory(
      {required int page, required int size}) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.savingHistory,
          queryParameters: {'page': page, 'size': size});
      List<dynamic> datas = response.data['data']['items'];

      return DataState<List<SavingHistoryModel>>(
          result: datas.map((e) => SavingHistoryModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<List<SavingHistoryModel>>().dio(e);
    }
  }

  @override
  Future<DataState<SavingPaymentMethodeModel>> getSavingPaymentMethode() async {
    try {
      final response =
          await RemoteProvider.get(path: Endpoint.savingPaymentMethode);
      return DataState<SavingPaymentMethodeModel>(
          result: SavingPaymentMethodeModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<SavingPaymentMethodeModel>().dio(e);
    }
  }

  @override
  Future<DataState<String>> savingInstallment(
      SavingInstallmentParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.savingInstallment, data: param.toMap());
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<SavingDirectModel>> savingDirect(
      SavingDirectParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.savingDirect, data: param.toMap());
      return DataState<SavingDirectModel>(
          result: SavingDirectModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<SavingDirectModel>().dio(e);
    }
  }

  @override
  Future<DataState<WaitingPaymentModel?>> waitingPayment() async {
    try {
      final response = await RemoteProvider.get(
        path: Endpoint.savingWaitingPayment,
      );
      return DataState<WaitingPaymentModel?>(
          // ignore: unnecessary_null_in_if_null_operators
          result: response.data['data'] != null
              ? WaitingPaymentModel.fromJson(response.data['data'])
              : null,
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<WaitingPaymentModel?>().dio(e);
    }
  }
}
