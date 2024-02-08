import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/refferal_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/refferal_model.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class RefferalRepositoryImpl implements RefferalRepository {
  @override
  Future<DataState<List<RefferalModel>>> getRefferal(
      {required int page, required int size}) async {
    String code = AppPreference().getUserData()?.user?.referral ?? '';
    try {
      final response = await RemoteProvider.get(
          path: "${Endpoint.referral}/$code/history",
          queryParameters: {'page': page, 'size': size, 'code': code});

      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<RefferalModel>>(
          result: datas.map((e) => RefferalModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(
              response: response, showLogs: true, queryParams: true),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<List<RefferalModel>>().dio(e);
    }
  }
}
