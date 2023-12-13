import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/model/model_data/payment_methode_model.dart';
import 'package:jetmarket/domain/core/model/params/auth/payment_param.dart';

import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../domain/core/model/model_data/payment_customer_model.dart';
import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../domain/core/model/model_data/user_model.dart';
import '../../../../domain/core/model/params/auth/forgot_param.dart';
import '../../../../domain/core/model/params/auth/forgot_verify_otp_param.dart';
import '../../../../domain/core/model/params/auth/login_param.dart';
import '../../../../domain/core/model/params/auth/register_param.dart';
import '../../../../domain/core/model/params/auth/register_virify_otp_param.dart';
import '../../../utils/app_preference/app_preferences.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<DataState<UserModel>> login(LoginParam param) async {
    try {
      final response =
          await RemoteProvider.post(path: Endpoint.login, data: param.toMap());
      await AppPreference().saveAccessToken(
          status: response.statusCode, token: response.data['data']['token']);
      await AppPreference().saveUserData(
        status: response.statusCode,
        data: response.data['data'],
      );

      return DataState<UserModel>(
          status: StatusCodeResponse.cek(response: response),
          result: UserModel.fromJson(response.data['data']));
    } on DioException catch (e) {
      return CustomException<UserModel>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> sendRegisterOtp(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpSend, data: {'email': param});
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> verifyRegisterOtp(
      RegisterVerifyOtpParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpVerify, data: param.toMap());
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<String>> verifyForgotOtp(ForgotVerifyOtpParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpVerify, data: param.toMap());

      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data']['token'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<UserModel>> register(RegisterParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.register, data: param.toMap());
      if (response.statusCode == 200) {
        AppPreference().saveAccessToken(
            status: 200, token: response.data['data']['token']);
        await AppPreference().saveUserData(
          status: response.statusCode,
          data: response.data['data'],
        );
      } else {}
      return DataState<UserModel>(
        status: StatusCodeResponse.cek(response: response),
        result: UserModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<UserModel>().dio(e);
    }
  }

  @override
  Future<bool?> forgot(ForgotParam param) async {
    return false;
  }

  @override
  Future<DataState<bool>> reset(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.reset, data: {"password": param});
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> sendOtp(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpSend, data: {'email': param, 'role': 'customer'});
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<PaymentMethodeModel>> getPaymentMethode() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.paymentMethode);
      return DataState<PaymentMethodeModel>(
        status: StatusCodeResponse.cek(response: response, showLogs: true),
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
        status: StatusCodeResponse.cek(response: response, showLogs: true),
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
        status: StatusCodeResponse.cek(response: response, showLogs: true),
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
  Future<DataState<String>> claimReferral(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.claimReferral, data: {"referral": param});
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data']['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> logout() async {
    try {
      final response = await RemoteProvider.post(path: Endpoint.logout);
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<String>> deleteAccount() async {
    try {
      final response =
          await RemoteProvider.delete(path: Endpoint.deleteAccount);
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }
}
