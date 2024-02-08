import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jetmarket/domain/core/interfaces/payment_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/payment_payletter.dart';

import '../../../domain/core/model/model_data/payment_customer_model.dart';
import '../../../domain/core/model/model_data/payment_methode_model.dart';
import '../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../domain/core/model/params/auth/payment_param.dart';
import '../../../utils/extension/payment_methode_type.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<DataState<PaymentMethodeModel>> getPaymentMethode(
      {required PaymentMethodeType type}) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.paymentMethode, queryParameters: {'type': type.label});
      return DataState<PaymentMethodeModel>(
        status: StatusCodeResponse.cek(
          response: response,
        ),
        result: PaymentMethodeModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<PaymentMethodeModel>().dio(e);
    }
  }

  @override
  Future<DataState<PaymentCustomerModel>> createPaymentCustomer(
      PaymentParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.paymentCustomerRegister,
          queryParameters: param.toMap());
      return DataState<PaymentCustomerModel>(
        status: StatusCodeResponse.cek(
          response: response,
        ),
        result: PaymentCustomerModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<PaymentCustomerModel>().dio(e);
    }
  }

  @override
  Future<DataState<PaymentCustomerModel>> getPaymentCustomer(int id) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.paymentCustomerRegister,
          queryParameters: {'trx_id': id});

      return DataState<PaymentCustomerModel>(
        status: StatusCodeResponse.cek(response: response, queryParams: true),
        result: PaymentCustomerModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<PaymentCustomerModel>().dio(e);
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

  @override
  Future<DataState<PaymentPayletter>> getPaymentPayletter(int amount) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.payletterPayment, queryParameters: {'amount': amount});
      return DataState<PaymentPayletter>(
        status: StatusCodeResponse.cek(
          response: response,
        ),
        result: response.data['data'] != null
            ? PaymentPayletter.fromJson(response.data['data'])
            : null,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<PaymentPayletter>().dio(e);
    }
  }
}
