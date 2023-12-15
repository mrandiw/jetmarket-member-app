import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import 'package:jetmarket/domain/core/model/params/product/product_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';

import '../../../domain/core/interfaces/product_repository.dart';
import '../../../domain/core/model/model_data/product.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/remote/remote_provider.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<DataState<List<CategoryProduct>>> getCategoryProduct() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.categoryProduct);
      List<dynamic> datas = response.data['data'];
      return DataState<List<CategoryProduct>>(
          result: datas.map((e) => CategoryProduct.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<CategoryProduct>>().dio(e);
    }
  }

  @override
  Future<DataState<List<Product>>> getProduct(ProductParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.product, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];

      return DataState<List<Product>>(
          result: datas.map((e) => Product.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response, showLogs: true));
    } on DioException catch (e) {
      return CustomException<List<Product>>().dio(e);
    }
  }
}
