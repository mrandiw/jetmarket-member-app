import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/loan_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/loan_entry_cancel_model.dart';
import 'package:jetmarket/domain/core/model/model_data/loan_propose_model.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_entry_param.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_propose_list_param.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_propose_param.dart';

import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class LoanRepositoryImpl implements LoanRepository {
  @override
  Future<DataState<int>> loanEntryId(LoanEntryParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.loanEntry, data: param.toMap());
      return DataState<int>(
          result: response.data['data']['loan_id'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<DetailLoanModel>> loanCancel(int id) async {
    try {
      final response = await RemoteProvider.post(
          path: "${Endpoint.loanPropose}/$id/cancel",
          queryParameters: {'id': id});
      return DataState<DetailLoanModel>(
          result: DetailLoanModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<DetailLoanModel>().dio(e);
    }
  }

  @override
  Future<DataState<int>> loanPropose(LoanProposeParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.loanPropose, data: param.toMap());
      return DataState<int>(
          result: response.data['data']['loan_propose_id'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<List<LoanProposeModel>>> getLoanPropose(
      LoanProposeListParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.loanPropose, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<LoanProposeModel>>(
          result: datas.map((e) => LoanProposeModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<List<LoanProposeModel>>().dio(e);
    }
  }

  @override
  Future<DataState<DetailLoanModel>> getDetailLoanPropose(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: "${Endpoint.loanPropose}/$id");
      return DataState<DetailLoanModel>(
          result: DetailLoanModel.fromJson(response.data['data']),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<DetailLoanModel>().dio(e);
    }
  }
}
