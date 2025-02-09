import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/app_version_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/app_version_model.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/remote/remote_provider.dart';
import 'package:jetmarket/utils/network/code_response.dart';
import 'package:jetmarket/utils/network/custom_exception.dart';
import 'package:jetmarket/utils/network/data_state.dart';

class AppVersionRepositoryImpl implements AppVersionRepository {
  @override
  Future<DataState<AppVersionModel>> getAppVersion() async {
    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.appVersion}?type_app=MEMBER');
      return DataState<AppVersionModel>(
          result: AppVersionModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<AppVersionModel>().dio(e);
    }
  }
}
