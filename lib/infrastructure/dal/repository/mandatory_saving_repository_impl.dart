import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/mandatory_saving_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/mandatory_saving_model.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/remote/remote_provider.dart';

import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';

class MandatorySavingRepositoryImpl implements MandatorySavingRepository {
  @override
  Future<DataState<int>> getTotalMandatorySaving() async {
    try {
      final response = await RemoteProvider.get(
        path: Endpoint.mandatorySavingTotal,
      );
      return DataState<int>(
        result: response.data['data']['total'] ?? 0,
        status: StatusCodeResponse.cek(response: response),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<MandatorySavingHistoryResponse>> getMandatorySavingHistory({
    required int page,
    required int size,
  }) async {
    try {
      final response = await RemoteProvider.get(
        path: Endpoint.mandatorySavingHistory,
        queryParameters: {'page': page, 'size': size},
      );
      return DataState<MandatorySavingHistoryResponse>(
        result: MandatorySavingHistoryResponse.fromJson(response.data['data']),
        status: StatusCodeResponse.cek(response: response),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<MandatorySavingHistoryResponse>().dio(e);
    }
  }
}
