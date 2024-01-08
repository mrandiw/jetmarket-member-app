import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/review_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/product_review_model.dart';
import 'package:jetmarket/domain/core/model/params/review/review_param.dart';
import 'package:jetmarket/utils/network/data_state.dart';

import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  @override
  Future<DataState<List<ProductReviewModel>>> getReview(int id) async {
    try {
      final response = await RemoteProvider.get(
          path: "${Endpoint.orderCustomer}/$id/review");
      List<dynamic> datas = response.data['data'];
      return DataState<List<ProductReviewModel>>(
        status: StatusCodeResponse.cek(response: response),
        result: datas.map((e) => ProductReviewModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return CustomException<List<ProductReviewModel>>().dio(e);
    }
  }

  @override
  Future<DataState<String>> sendReview(ReviewParam? param) async {
    try {
      final response = await RemoteProvider.post(
          path: "${Endpoint.orderCustomer}/${param?.id}/review",
          data: param?.toMap()['body']);
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response, showLogs: true),
        result: response.data['data'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }
}
