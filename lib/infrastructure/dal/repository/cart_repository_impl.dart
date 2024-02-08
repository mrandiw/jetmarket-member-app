import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/cart_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/cart_product.dart';
import 'package:jetmarket/domain/core/model/params/cart/cart_body.dart';
import 'package:jetmarket/domain/core/model/params/cart/cart_product_param.dart';
import 'package:jetmarket/domain/core/model/params/cart/update_qty_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';

import '../../../domain/core/model/params/cart/update_note_param.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/remote/remote_provider.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  Future<DataState<String>> addToCart(CartBody body) async {
    try {
      final response =
          await RemoteProvider.post(path: Endpoint.cart, data: body.toMap());
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<List<CartProduct>>> getCartProduct(
      CartProductParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.cart, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<CartProduct>>(
          result: datas.map((e) => CartProduct.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<CartProduct>>().dio(e);
    }
  }

  @override
  Future<DataState<String>> updateQty(UpdateQtyParam param) async {
    try {
      final response = await RemoteProvider.put(
          path: Endpoint.cartQty, queryParameters: param.toMap());
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<String>> updateNote(UpdateNoteParam param) async {
    try {
      final response = await RemoteProvider.put(
          path: Endpoint.cartNote, queryParameters: param.toMap());
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<String>> deleteProduct(List<int> id) async {
    try {
      final response = await RemoteProvider.delete(
          path: Endpoint.cartBulkDelete, queryParameters: {'cart_ids': id});
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }
}
