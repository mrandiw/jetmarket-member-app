import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_shop.dart';
import 'package:jetmarket/domain/core/model/model_data/product_review_customer.dart';
import 'package:jetmarket/domain/core/model/params/product/product_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';

import '../../../domain/core/interfaces/product_repository.dart';
import '../../../domain/core/model/model_data/banner.dart';
import '../../../domain/core/model/model_data/detail_product.dart';
import '../../../domain/core/model/model_data/product.dart';
import '../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../domain/core/model/params/product/product_seller_param.dart';
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
  Future<DataState<List<CategoryProduct>>> getCategoryProductBySeller(
      int id) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.categoryProductBySeller,
          queryParameters: {"seller_id": id});
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
          status:
              StatusCodeResponse.cek(response: response, queryParams: true));
    } on DioException catch (e) {
      return CustomException<List<Product>>().dio(e);
    }
  }

  @override
  Future<DataState<DetailProduct>> getProductById(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: "${Endpoint.product}/$id");
      return DataState<DetailProduct>(
          result: DetailProduct.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(
            response: response,
          ));
    } on DioException catch (e) {
      return CustomException<DetailProduct>().dio(e);
    }
  }

  @override
  Future<DataState<List<Product>>> getProductBySeller(
      ProductSellerParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.productBySeller, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<Product>>(
          result: datas.map((e) => Product.fromJson(e)).toList(),
          status:
              StatusCodeResponse.cek(response: response, queryParams: true));
    } on DioException catch (e) {
      return CustomException<List<Product>>().dio(e);
    }
  }

  @override
  Future<DataState<List<Banners>>> getBanner() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.banner);
      List<dynamic> datas = response.data['data'];
      return DataState<List<Banners>>(
          result: datas.map((e) => Banners.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<Banners>>().dio(e);
    }
  }

  @override
  Future<DataState<List<ProductReviewCustomer>>> getProductReview(
      int id) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.productReview,
          queryParameters: {'product_id': id, 'page': 1, 'size': 10});
      List<dynamic> datas = response.data['data']['items'];

      return DataState<List<ProductReviewCustomer>>(
          result: datas.map((e) => ProductReviewCustomer.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(
            response: response,
          ));
    } on DioException catch (e) {
      return CustomException<List<ProductReviewCustomer>>().dio(e);
    }
  }

  @override
  Future<DataState<DetailShop>> getDetailShop(int id) async {
    try {
      final response = await RemoteProvider.get(path: "${Endpoint.shop}/$id");
      return DataState<DetailShop>(
          result: DetailShop.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response, showLogs: true));
    } on DioException catch (e) {
      return CustomException<DetailShop>().dio(e);
    }
  }

  @override
  Future<TutorialPaymentVaModel> fetchDataFromJsonFile(String path) async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/tutorial_$path.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      TutorialPaymentVaModel tutorialModel =
          TutorialPaymentVaModel.fromJson(jsonMap);
      return tutorialModel;
    } catch (e) {
      throw "Error: $e";
    }
  }
}
