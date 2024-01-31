import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/model/model_data/balance_history_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_topup_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_withdraw_model.dart';
import 'package:jetmarket/domain/core/model/params/wallet/send_withdraw_body.dart';
import 'package:jetmarket/domain/core/model/params/wallet/wallet_topup_body.dart';
import 'package:jetmarket/domain/core/model/params/wallet/wallet_withdraw_body.dart';
import 'package:jetmarket/utils/network/custom_exception.dart';

import '../../../domain/core/interfaces/ewallet_repository.dart';
import '../../../domain/core/model/model_data/waiting_payment_model.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class EwalletRepositoryImpl implements EwalletRepository {
  @override
  Future<DataState<int>> getWalletBalance() async {
    try {
      final response = await RemoteProvider.get(path: Endpoint.eWalletBalance);
      return DataState<int>(
          result: response.data['data']['balance'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<List<BalanceHistoryModel>>> getBalanceHistory(
      {required int page, required int size}) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.eWalletBalanceHistory,
          queryParameters: {'page': page, 'size': size});
      List<dynamic> datas = response.data['data']['items'];

      return DataState<List<BalanceHistoryModel>>(
        result: datas.map((e) => BalanceHistoryModel.fromJson(e)).toList(),
        status: StatusCodeResponse.cek(response: response, showLogs: true),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<BalanceHistoryModel>>().dio(e);
    }
  }

  @override
  Future<DataState<List<String>>> getPaymentMethode() async {
    try {
      final response =
          await RemoteProvider.get(path: Endpoint.eWalletWithdrawPaymentMethod);

      String bankString = response.data['data']['payment_methods'];
      List<String> bankList = bankString.split(', ');

      return DataState<List<String>>(
        result: bankList,
        status: StatusCodeResponse.cek(response: response),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<String>>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> walletWithdraw(EwalletWithdrawBody body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.eWalletWithdraw, data: body.toMap());
      return DataState(
        result: true,
        status: StatusCodeResponse.cek(response: response),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<DetailWithdrawModel>> getDetailWithdraw(
      {required String id}) async {
    String modifiedId = id.replaceAll('#', '%23');
    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.eWalletWithdraw}/$modifiedId');
      return DataState<DetailWithdrawModel>(
          result: DetailWithdrawModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<DetailWithdrawModel>().dio(e);
    }
  }

  @override
  Future<DataState<DetailTopupModel>> getDetailTopup(
      {required String id}) async {
    String modifiedId = id.replaceAll('#', '%23');
    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.ewalletTopup}/$modifiedId');
      return DataState<DetailTopupModel>(
          result: DetailTopupModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<DetailTopupModel>().dio(e);
    }
  }

  @override
  Future<DataState<String>> topUpWallet(WalletTopupBody body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.ewalletTopup, data: body.toMap());
      return DataState<String>(
        result: response.data['data']['ref_id'],
        status: StatusCodeResponse.cek(response: response),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<WaitingPaymentModel>> getTransaction(String id) async {
    String modifiedId = id.replaceAll('#', '%23');

    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.ewalletTopup}/$modifiedId/transaction');

      return DataState<WaitingPaymentModel>(
        status: StatusCodeResponse.cek(response: response),
        result: WaitingPaymentModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<WaitingPaymentModel>().dio(e);
    }
  }

  @override
  Future<DataState<String>> sendWidthdraw(SendWithdrawBody body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.eWalletWithdraw, data: body.toMap());
      return DataState<String>(
          result: response.data['data']['ref_id'],
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> cancelWithdraw(String id) async {
    String modifiedId = id.replaceAll('#', '%23');

    try {
      final response = await RemoteProvider.post(
          path: '${Endpoint.eWalletWithdraw}/$modifiedId/cancel');

      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
        result: true,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }
}
