import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/model/model_data/balance_history_model.dart';
import 'package:jetmarket/utils/network/custom_exception.dart';

import '../../../domain/core/interfaces/ewallet_repository.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class EwalletRepositoryImpl implements EwalletRepository {
  @override
  Future<DataState<int>> getWalletBalance() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.eWalletBalance);
      return DataState<int>(
          result: response.data['data']['balance'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<List<BalanceHistoryModel>>> getBalanceHistory(
      {required int page, required int size}) async {
    try {
      final response =
          await RemoteProvider.get(path: Endpoint.eWalletBalanceHistory);
      List<dynamic> datas = response.data['data']['items'];

      return DataState<List<BalanceHistoryModel>>(
        result: datas.map((e) => BalanceHistoryModel.fromJson(e)).toList(),
        status: StatusCodeResponse.cek(response: response),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<BalanceHistoryModel>>().dio(e);
    }
  }
}
