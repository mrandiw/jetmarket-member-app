import 'package:jetmarket/domain/core/model/model_data/loan_bill_model.dart';
import 'package:jetmarket/domain/core/model/model_data/loan_entry_cancel_model.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_entry_param.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_propose_param.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/detail_loan_bill_model.dart';
import '../model/model_data/loan_bill_check.dart';
import '../model/model_data/loan_pay_bill_model.dart';
import '../model/model_data/loan_propose_model.dart';
import '../model/params/loan/loan_bill.dart';
import '../model/params/loan/loan_propose_list_param.dart';

abstract class LoanRepository {
  Future<DataState<int>> loanEntryId(LoanEntryParam param);
  Future<DataState<DetailLoanModel>> loanCancel(int id);
  Future<DataState<int>> loanPropose(LoanProposeParam param);
  Future<DataState<List<LoanProposeModel>>> getLoanPropose(
      LoanProposeListParam param);
  Future<DataState<DetailLoanModel>> getDetailLoanPropose(int id);
  Future<DataState<List<LoanBillModel>>> getLoanBill(
      {required int page, required int size});
  Future<DataState<DetailLoanBillModel>> getDetailLoanBill(int id);
  Future<DataState<LoanBillCheckModel>> getLoanBillCheck();
  Future<DataState<LoanPayBillModel>> loanBill(LoanBillParam param);
}
