import 'package:dio/dio.dart';
import '../../../domain/core/interfaces/file_repository.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class FileRepositoryImpl implements FileRepository {
  @override
  Future<DataState<String>> uploadFile(
      {required String name, required String image}) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'images': await MultipartFile.fromFile(image, filename: name),
      });
      final response =
          await RemoteProvider.post(path: Endpoint.fileImage, data: formData);
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data'][0],
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }
}
